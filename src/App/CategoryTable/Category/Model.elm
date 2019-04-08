module App.CategoryTable.Category.Model exposing ( Model, newCategory )

import App.CategoryTable.Link.Model

type alias Model =
    { name : String
    , color : String
    , links : List App.CategoryTable.Link.Model.Model
    , id : Int
    }

newCategory : String -> String -> Int -> Model
newCategory name color id =
    { name = name
    , color = color
    , links = []
    , id = id
    }

