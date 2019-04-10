module App.CategoryTable.Link.View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)

import App.CategoryTable.Category.Messages exposing ( Msg(..) )
import App.CategoryTable.Link.Model exposing (Model)

view : Bool -> Model -> Html Msg
view editMode model = 
  let 
    attributes =
      if editMode then
        [ onClick (RemoveLink model.id)
        , href "#"
        ]
      else [ href model.url ]
  in
    a 
      attributes
      [ span
        [ classList 
          [ ( "item", True )
          , ( "crossOut", editMode ) 
          ]
        ]
        [ text model.name ]
      ]