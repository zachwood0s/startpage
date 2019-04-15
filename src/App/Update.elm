port module App.Update exposing (updateWithStorage)

import App.Messages exposing (Msg(..))
import App.Model exposing (Model, StoredModel, asCategoryTableIn, asStoredModelIn, asFooterModelIn)
import App.CategoryTable.Update
import App.CategoryTable.Model exposing (initEdit)
import App.Footer.Update 

port setStorage : StoredModel -> Cmd msg

updateWithStorage : Msg -> Model -> ( Model, Cmd Msg )
updateWithStorage msg model =
  let
    ( newModel, cmds ) =
      update msg model
  in
    ( newModel
    , Cmd.batch [ setStorage newModel.storedModel, cmds ]
    )

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
    
    ToggleEditMode ->
      let 
        updatedEditMode = not model.editMode
        storedModel = 
          if updatedEditMode then 
            initEdit model.storedModel.categoryTable
            |> asCategoryTableIn model.storedModel
          else model.storedModel
      in
        ( { model 
          | editMode = updatedEditMode
          , storedModel = storedModel 
          }
        , Cmd.none 
        )

    FooterMsg footerMsg ->
      let 
        ( footerModel, footerCmd ) =
          App.Footer.Update.update footerMsg model.footerModel
      in 
        ( footerModel 
          |> asFooterModelIn model 
        , Cmd.map FooterMsg footerCmd 
        )
          



