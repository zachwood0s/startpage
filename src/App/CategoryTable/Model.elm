module App.CategoryTable.Model exposing 
    (Model, emptyCategoryTable, setCategories, addCategory, setUid, asCategoriesIn, initEdit)

import App.CategoryTable.Category.Model as CategoryModel
import Utils exposing ( flip )

type alias Model = 
    { categories : List CategoryModel.Model
    , uid : Int
    , addMode : Bool
    , inputField : String
    , selectedColor : String
    , colorMode : Bool
    }

emptyCategoryTable : Model
emptyCategoryTable =
    { categories = []
    , uid = 0
    , addMode = False
    , inputField = ""
    , colorMode = False
    , selectedColor = ""
    }

initEdit : Model -> Model
initEdit previous =
    { previous 
    | categories = List.map CategoryModel.initEdit previous.categories 
    , addMode = False
    , inputField = ""
    , colorMode = False 
    , selectedColor = "accent00"
    }

setCategories : List CategoryModel.Model -> Model -> Model
setCategories categories model =
    { model | categories = categories }

asCategoriesIn : Model -> List CategoryModel.Model -> Model
asCategoriesIn = flip setCategories

addCategory : CategoryModel.Model -> Model -> Model
addCategory category model =
    model.categories ++ [ category ]
    |> asCategoriesIn model

setUid : Int -> Model -> Model
setUid uid model =
    { model | uid = uid }


