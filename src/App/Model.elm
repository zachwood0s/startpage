module App.Model exposing ( Model, StoredModel, Flags, init, asCategoryTableIn, setCategoryTable, asStoredModelIn, asFooterModelIn)

import App.CategoryTable.Model
import App.Messages exposing (..)
import Utils exposing ( flip )
import App.Theme.ColorScheme exposing (Theme, ColorMap)
import App.Footer.Model

type alias Model =
  { storedModel : StoredModel
  , editMode : Bool 
  , colorMap : ColorMap
  , theme : Theme
  , footerModel : App.Footer.Model.Model
  }

type alias StoredModel = 
  { categoryTable : App.CategoryTable.Model.Model
  , greeting : String 
  }

type alias Flags = Maybe StoredModel

init : Maybe StoredModel -> ( Model, Cmd Msg )
init maybeModel =
  let 
    (footerModel, footerCmd) = App.Footer.Model.init 
  in
    ( footerModel 
    |> asFooterModelIn (emptyModel ( Maybe.withDefault emptyStoredModel maybeModel))
    , Cmd.map FooterMsg footerCmd
    )

emptyModel : StoredModel -> Model
emptyModel stored = 
    Model stored False 
      (App.Theme.ColorScheme.initColorMap Nothing)
      (App.Theme.ColorScheme.initTheme Nothing)
      App.Footer.Model.emptyModel

emptyStoredModel : StoredModel
emptyStoredModel = 
    { categoryTable = App.CategoryTable.Model.emptyCategoryTable
    , greeting = "Hello"
    }

-- Model Accessors

setStoredModel : StoredModel -> Model -> Model
setStoredModel stored model =
  { model | storedModel = stored }

setFooterModel : App.Footer.Model.Model -> Model -> Model 
setFooterModel footer model =
  { model | footerModel = footer }

asStoredModelIn : Model -> StoredModel -> Model
asStoredModelIn = flip setStoredModel

asFooterModelIn :  Model -> App.Footer.Model.Model -> Model 
asFooterModelIn = flip setFooterModel

-- Stored Model Accessors

setCategoryTable : App.CategoryTable.Model.Model -> StoredModel -> StoredModel
setCategoryTable table model =
  { model | categoryTable = table }

asCategoryTableIn : StoredModel -> App.CategoryTable.Model.Model -> StoredModel
asCategoryTableIn = flip setCategoryTable
