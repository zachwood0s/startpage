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

main : Program (Maybe StoredModel) Model Msg
main =
  Browser.document
    { init = init
    , view = \model -> { title = "New Tab", body = [view model]}
    , update = updateWithStorage
    , subscriptions = subscriptions
    }

port setStorage : StoredModel -> Cmd msg

updateWithStorage : Msg -> Model -> (Model, Cmd Msg)
updateWithStorage msg model =
  let 
    ( newModel, cmds ) =
      update msg model
  in
    ( newModel 
    , Cmd.batch [ setStorage newModel.storedModel, cmds ]
    )

flip : (a -> b -> c) -> b -> a -> c
flip func =
  \b -> \a -> func a b

--Subscriptions

subscriptions model = 
  Time.every 1000 OnTime

--Model

type alias Model = 
  { storedModel : StoredModel
  , editMode : Bool
  , time : Time.Posix
  , zone : Time.Zone
  , addCatMode : Bool
  , categoryField : String
  , addLinkMode : Bool
  , addLinkId : Int
  , linkFieldName : String
  , linkFieldUrl : String
  }

setStoredModel : StoredModel -> Model -> Model
setStoredModel stored model =
  { model | storedModel = stored }

asStoredModelIn : Model -> StoredModel -> Model
asStoredModelIn = flip setStoredModel

type alias StoredModel = 
  { categories : List Category
  , greeting : String 
  , uid : Int
  }

setUid : Int -> StoredModel -> StoredModel
setUid uid model =
  { model | uid = uid }

asUidIn : StoredModel -> Int -> StoredModel
asUidIn = flip setUid

setCategories : List Category -> StoredModel -> StoredModel
setCategories cats model =
  { model | categories = cats }

asCategoriesIn : StoredModel -> List Category -> StoredModel
asCategoriesIn = flip setCategories

addCategory : Category -> StoredModel -> StoredModel
addCategory cat model = 
  { model | categories = model.categories ++ [ cat ] }

setGreeting : String -> StoredModel -> StoredModel
setGreeting greet model =
  { model | greeting = greet }
  

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

newCategory : String -> String -> Int -> Category
newCategory name color id =
  { name = name
  , color = color
  , links = []
  , id = id 
  }

emptyStoredModel : StoredModel
emptyStoredModel = 
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
  , greeting = "Hello"
  , uid = 2
  }

emptyModel : StoredModel -> Model
emptyModel stored = 
  { storedModel = stored
  , editMode = False
  , time = Time.millisToPosix 0
  , zone = Time.utc
  , addCatMode = False
  , categoryField = ""
  , addLinkMode = False
  , addLinkId = 0
  , linkFieldName = ""
  , linkFieldUrl = ""
  }

init : Maybe StoredModel -> ( Model, Cmd Msg )
init maybeModel = 
  ( emptyModel emptyStoredModel--<| Maybe.withDefault emptyStoredModel maybeModel
  , Task.perform AdjustTimeZone Time.here
  )


--Update

type Msg
  = NoOp
  | OnTime Time.Posix
  | AdjustTimeZone Time.Zone
  | SetEdit Bool
  | RemoveCategory Int
  | AddCategoryMode
  | AddCategory
  | AddLinkMode Int
  | UpdateCategoryField String

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
      ( List.filter (\c -> c.id /= id) model.storedModel.categories
        |> asCategoriesIn model.storedModel
        |> asStoredModelIn model 
      , Cmd.none
      )
    UpdateCategoryField text ->
      ( { model | categoryField = text }, Cmd.none )
    AddCategoryMode ->
      ( { model | addCatMode = not model.addCatMode }, Cmd.none )
    AddCategory -> 
      let 
        newCat id = newCategory model.categoryField "base08" id
      in
        ( model.storedModel
          |> setUid (model.storedModel.uid + 1)
          |> addCategory (newCat model.storedModel.uid)
          |> asStoredModelIn model
        , Cmd.none
        )


--View

view : Model -> Html Msg
view model = 
  div 
    [ class "content" ] 
    [ viewGreeting model.storedModel.greeting 
    , viewCategories model.editMode model.addCatMode model.storedModel.categories
    , viewFooter model
    ]

viewGreeting : String -> Html Msg
viewGreeting greeting =
  h1 [] [ text greeting ]

viewCategories : Bool -> Bool -> List Category -> Html Msg
viewCategories editMode addCat categories =
  let
    addCategoryButton = 
      if editMode then 
        tr [] [ td [ colspan 3 ] [ viewAddButton "Name" addCat AddCategoryMode ]]
      else text ""
  in
    table [ id "links" ] <|
      List.map (lazy2 viewCategory editMode) categories ++ [ addCategoryButton ]

viewAddButton : String -> Bool -> Msg -> Html Msg
viewAddButton intext expanded msg = 
  div 
    [ classList 
      [ ("addButton ", True)
      , ("expanded", expanded )  
      ]
    ]
    [ span 
        [ class "plus" 
        , onClick msg
        ]
        [ text "+"]
    , input 
      [ placeholder intext 
      , onInput UpdateCategoryField
      , onEnter AddCategory
      ] []
    ]


onEnter : Msg -> Attribute Msg
onEnter msg =
  let 
    isEnter code =
      if code == 13 then
        Json.succeed msg
      else
        Json.fail "not ENTER"
  in
    on "keydown" (Json.andThen isEnter keyCode)



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
  