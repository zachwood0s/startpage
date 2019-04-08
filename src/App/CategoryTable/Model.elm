module App.CategoryTable.Model exposing (Model, emptyCategoryTable)

import App.CategoryTable.Category.Model

type alias Model = 
    { categories : List App.CategoryTable.Category.Model.Model
    , uid : Int
    , addMode : Bool
    , inputField : String
    }

emptyCategoryTable : Model
emptyCategoryTable =
    { categories = []
    , uid = 0
    , addMode = False
    , inputField = ""
    }

