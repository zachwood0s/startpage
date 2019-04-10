module App.Footer.View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)

import App.Model exposing (Model)
import App.Messages exposing (Msg(..))

view : Model -> Html Msg
view model = 
  footer []
    [ viewEdit model.editMode 
    ]

viewEdit : Bool -> Html Msg
viewEdit editMode =
  let 
    iconBackground = 
      if editMode then "base04"
      else "base03"
  in
    div
      [ id "editIcon" 
      , class ( "circle background-" ++ iconBackground )
      , onClick ToggleEditMode
      ] []