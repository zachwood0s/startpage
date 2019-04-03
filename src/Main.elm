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
  , uid : Int
  }

type alias Category = 
  { name : String
  , color : String
  , links : List Link
  , id : Int
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
      , id = 0
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
      , id = 1
      , links = 
        [
          { name = "ksis"
          , link = "lds"
          }
        ]
      }
    ]
  , greeting = "Fuck You"
  , time = Time.millisToPosix 0
  , zone = Time.utc
  , editMode = True
  , uid = 0
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
  | SetEdit Bool
  | RemoveCategory Int
  | AddCategory

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
    SetEdit val -> 
      ( { model | editMode = val }
      , Cmd.none
      )
    RemoveCategory id ->
      ( { model | categories = List.filter (\c -> c.id /= id ) model.categories }
      , Cmd.none
      )

    AddCategory ->
      ( model, Cmd.none )


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

    removeButton = 
      if editMode then 
        td 
          [ class "edit" 
          , onClick <| RemoveCategory category.id
          ] 
          [ text "-" ]
      else td [] []
  in
    tr
      [ class className ] <|
      [ removeButton
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
    , viewEdit model.editMode
    ]

viewEdit : Bool -> Html Msg
viewEdit editModeOn =
  let
    iconBackground = 
      if editModeOn then "base04"
      else "base03"
  in
    div 
      [ id "editIcon"
      , class ( "circle background-" ++ iconBackground )
      , onClick <| SetEdit (not editModeOn)
      ]
      []

viewTime : Time.Posix -> Time.Zone -> Html Msg
viewTime time zone =
  let
    hour = Time.toHour zone time
    minute = Time.toMinute zone time

    printedHour = 
      if hour < 10 then "0" ++ String.fromInt hour
      else String.fromInt hour
    
    printedMinute = 
      if minute < 10 then "0" ++ String.fromInt minute
      else String.fromInt minute
  in
    div 
      [ id "time" 
      , class "color-base03"
      ]
      [ text (printedHour ++ ":" ++ printedMinute) ]
  