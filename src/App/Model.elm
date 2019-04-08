module App.Model exposing ( Model, StoredModel, Flags, init )

import App.CategoryTable.Model
import App.Messages exposing (..)

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
    ( emptyModel emptyStoredModel
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

