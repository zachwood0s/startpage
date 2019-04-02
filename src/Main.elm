port module Main exposing (..)

import Browser
import Browser.Dom as Dom
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Html.Keyed as Keyed
import Html.Lazy exposing (lazy, lazy2)
import Json.Decode as Json
import Task
import Time

main : Program () Model Msg
main =
  Browser.document
    { init = init
    , view = \model -> { title = "New Tab", body = [view model]}
    , update = update
    , subscriptions = subscriptions
    }

--port setStorage : Model -> Cmd msg

{-
updateWithStorage : Msg -> Model -> (Model, Cmd Msg)
updateWithStorage msg model =
  let 
    ( newModel, cmds ) =
      update msg model
  in
    ( newModel 
    , Cmd.batch [ setStorage newModel, cmds ]
    )
-}

--Subscriptions

subscriptions model = 
  Time.every 1000 OnTime

--Model

type alias Model = 
  { categories : List Category
  , greeting : String
  , editMode : Bool
  , time : Time.Posix
  , zone : Time.Zone
  }

type alias Category = 
  { name : String
  , color : String
  , links : List Link
  }

type alias Link =
  { name : String
  , link : String
  }

emptyModel : Model
emptyModel = 
  { categories = 
    [
      { name = "kstate"
      , color = "base08"
      , links = 
        [
          { name = "ksis"
          , link = "blah"
          }
        , { name = "ksis"
          , link = "blah"
          }
        ]
      }
    , { name = "kstate"
      , color = "base10"
      , links = 
        [
          { name = "ksis"
          , link = "lds"
          }
        ]
      }
    ]
  , greeting = "Hello"
  , time = Time.millisToPosix 0
  , zone = Time.utc
  , editMode = True
  }

init : () -> ( Model, Cmd Msg )
init _ = 
  ( emptyModel
  , Task.perform AdjustTimeZone Time.here
  )


--Update

type Msg
  = NoOp
  | OnTime Time.Posix
  | AdjustTimeZone Time.Zone

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model = 
  case msg of 
    NoOp -> ( model, Cmd.none )
    OnTime t ->
      ( { model | time = t }
      , Cmd.none
      )
    AdjustTimeZone newZone ->
      ( { model | zone = newZone }
      , Cmd.none
      )


--View

view : Model -> Html Msg
view model = 
  div 
    [ class "content" ] 
    [ viewGreeting model.greeting 
    , viewCategories model.editMode model.categories
    , viewFooter model
    ]

viewGreeting : String -> Html Msg
viewGreeting greeting =
  h1 [] [ text greeting ]

viewCategories : Bool -> List Category -> Html Msg
viewCategories editMode categories =
  table [ id "links" ] <|
    List.map (lazy2 viewCategory editMode) categories 

viewCategory : Bool -> Category -> Html Msg
viewCategory editMode category =
  let 
    title =
      td
        [ class "title" ]
        [ text category.name ]

    className = "category color-" ++ category.color

    editButton = 
      if editMode then td [] [text "-"]
      else td [] []
  in
    tr
      [ class className ] <|
      [ editButton
      , title
      , viewLinks category.links
      ]
    
viewLinks : List Link -> Html Msg
viewLinks links =
  td [] <|
    List.map (lazy viewLink) links 

viewLink : Link -> Html Msg
viewLink link = 
  a 
    [ href link.link ]
    [ span 
      [ class "item" ]
      [ text link.name ]
    ]

viewFooter : Model -> Html Msg
viewFooter model =
  footer []
    [ viewTime model.time model.zone
    ]

viewTime : Time.Posix -> Time.Zone -> Html Msg
viewTime time zone =
  let
      hour = String.fromInt (Time.toHour zone time)
      minute = String.fromInt (Time.toMinute zone time)
  in
    div 
      [ id "time" 
      , class "color-base03"
      ]
      [ text (hour ++ ":" ++ minute) ]
  