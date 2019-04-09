module App.Update exposing (update)

import App.Messages exposing (Msg(..))
import App.Model exposing (Model, asCategoryTableIn, asStoredModelIn)
import App.CategoryTable.Update

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model = 
  case msg of 
    NoOp -> ( model, Cmd.none )

    CategoryTableMsg tableMsg ->
      let
        ( tableModel, tableCmd ) =
          App.CategoryTable.Update.update tableMsg model.storedModel.categoryTable
      in
        ( tableModel
          |> asCategoryTableIn model.storedModel
          |> asStoredModelIn model
        , Cmd.map CategoryTableMsg tableCmd
        )
