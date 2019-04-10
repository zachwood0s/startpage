module App.CategoryTable.Category.Update exposing ( update )

import App.CategoryTable.Category.Messages exposing ( Msg(..) )
import App.CategoryTable.Category.Model exposing ( Model, addLink, asLinksIn )
import App.CategoryTable.Link.Model exposing ( newLink )

import Validate exposing (Validator, ifBlank, validate )

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model = 
  case msg of
    NoOp -> ( model, Cmd.none )

    AddMode -> 
      ( { model | addMode = not model.addMode }, Cmd.none )

    UpdateUrlField str -> 
      ( { model | urlField = str }, Cmd.none )

    UpdateNameField str ->
      ( { model | nameField = str }, Cmd.none )

    Add -> 
      let
        newUid = model.uid + 1
        newModel = 
          if inputValidator model then
            addLink (newLink model.nameField model.urlField newUid ) model
          else model
      in
        ( { newModel | uid = newUid }, Cmd.none )
    
    RemoveLink id ->
      ( List.filter (\l -> l.id /= id ) model.links
        |> asLinksIn model
      , Cmd.none
      )

    _ -> ( model, Cmd.none )

  
inputValidator : Model -> Bool
inputValidator =
  Validate.any
    [ ifBlank .urlField "Enter a url"
    , ifBlank .nameField "Enter a name"
    ]