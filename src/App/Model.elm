module App.Model exposing ( Model, StoredModel, Flags, init, asCategoryTableIn, setCategoryTable, asStoredModelIn)

import App.CategoryTable.Model
import App.Messages exposing (..)
import Utils exposing ( flip )

type alias Model =
  { storedModel : StoredModel
  , editMode : Bool 
  }

type alias StoredModel = 
  { categoryTable : App.CategoryTable.Model.Model
  , greeting : String 
  }

type alias Flags = Maybe StoredModel

init : Maybe StoredModel -> ( Model, Cmd Msg )
init maybeModel =
    ( emptyModel ( Maybe.withDefault emptyStoredModel maybeModel)
    , Cmd.none
    )

emptyModel : StoredModel -> Model
emptyModel stored = 
    Model stored False 

emptyStoredModel : StoredModel
emptyStoredModel = 
    { categoryTable = App.CategoryTable.Model.emptyCategoryTable
    , greeting = "Hello"
    }

-- Model Accessors

setStoredModel : StoredModel -> Model -> Model
setStoredModel stored model =
  { model | storedModel = stored }

asStoredModelIn : Model -> StoredModel -> Model
asStoredModelIn = flip setStoredModel

-- Stored Model Accessors

setCategoryTable : App.CategoryTable.Model.Model -> StoredModel -> StoredModel
setCategoryTable table model =
  { model | categoryTable = table }

asCategoryTableIn : StoredModel -> App.CategoryTable.Model.Model -> StoredModel
asCategoryTableIn = flip setCategoryTable
