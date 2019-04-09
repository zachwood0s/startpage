module App.CategoryTable.Link.View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)

import App.CategoryTable.Category.Messages exposing ( Msg(..) )
import App.CategoryTable.Link.Model exposing (Model)

view : Model -> Html Msg
view model = 
  a 
    [ href model.url ]
    [ span
      [ class "item" ]
      [ text model.name ]
    ]