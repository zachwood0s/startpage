module App.CategoryTable.Category.Model exposing ( Model, newCategory, addLink, asLinksIn, initEdit)

import App.CategoryTable.Link.Model as LinkModel
import Utils exposing (flip)

type alias Model =
    { name : String
    , color : String
    , links : List LinkModel.Model
    , id : Int
    , addMode : Bool
    , nameField : String
    , urlField : String
    , uid : Int
    }

newCategory : String -> String -> Int -> Model
newCategory name color id =
    { name = name
    , color = color
    , links = []
    , id = id
    , addMode = False
    , nameField = ""
    , urlField = ""
    , uid = 0
    }

initEdit : Model -> Model
initEdit previous =
    { previous 
    | nameField = "" 
    , urlField = "" 
    , addMode = False 
    }

setLinks : List LinkModel.Model -> Model -> Model
setLinks links model =
    { model | links = links }

asLinksIn : Model -> List LinkModel.Model -> Model
asLinksIn = flip setLinks

addLink : LinkModel.Model -> Model -> Model
addLink link model =
    model.links ++ [link]
    |> asLinksIn model


