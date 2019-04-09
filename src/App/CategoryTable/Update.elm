module App.CategoryTable.Update exposing ( update )

import List.Extra
import App.CategoryTable.Model exposing (..)
import App.CategoryTable.Messages exposing ( Msg(..) )
import App.CategoryTable.Category.Model exposing ( newCategory )
import App.CategoryTable.Category.Update
import App.CategoryTable.Category.Messages as CategoryMessages

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model = 
    case msg of
        NoOp -> ( model, Cmd.none )
  
        UpdateField str ->
            ( { model | inputField = str }, Cmd.none )

        AddMode -> 
            ( { model | addMode = not model.addMode }, Cmd.none )
        
        Add -> 
            ( model 
              |> setUid (model.uid + 1)
              |> addCategory (newCategory model.inputField "base08" model.uid)
            , Cmd.none
            )
        
        CategoryMsg id categoryMsg ->
            case categoryMsg of
                CategoryMessages.RemoveCategory -> 
                    ( List.filter (\c -> c.id /= id) model.categories
                      |> asCategoriesIn model
                    , Cmd.none
                    )
                _ -> handleCategoryMsgPassthrough id categoryMsg model

handleCategoryMsgPassthrough : Int -> CategoryMessages.Msg -> Model -> ( Model, Cmd Msg )
handleCategoryMsgPassthrough id innerMsg model =
    let
        mayBeIndex = ( List.Extra.findIndex (\item -> item.id == id) model.categories )

        index = 
            case mayBeIndex of
                Just idx -> idx
                Nothing -> -1

        selectedCategory = 
            case ( List.Extra.getAt index model.categories ) of
                Just category -> category
                Nothing -> newCategory "" "" -1

        ( updatedCategory, cmdMsg ) =
            App.CategoryTable.Category.Update.update innerMsg selectedCategory

        categories =
            List.Extra.setAt index updatedCategory model.categories
    in
        ( model |> setCategories categories 
        , Cmd.map (CategoryMsg id) cmdMsg 
        )

            
