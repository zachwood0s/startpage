module App.CategoryTable.Category.View exposing ( view )

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import Html.Lazy exposing (lazy, lazy2)
import Utils exposing (onEnter)
--import Html.Events exposing

import App.CategoryTable.Category.Model exposing ( Model )
import App.CategoryTable.Category.Messages exposing ( Msg(..) )
import App.CategoryTable.Link.Model as LinkModel
import App.CategoryTable.Link.View as LinkView

view : Bool -> Model -> Html Msg
view editMode model = 
  let
    title = 
      td
        [ class "title" ]
        [ text model.name ]

    removeButton =
      if editMode then
        td 
          [ class "edit"
          , onClick RemoveCategory
          ]
          [ text "-" ]
      else td [] []
    
    addButton = 
      if editMode then
        td [] [ viewAddButton model.addMode ]
      else text ""
  in
    tr
      [ classList 
        [ ("category", True)
        , ("color-" ++ model.color, True)
        ]
      ]
      [ removeButton
      , title
      , viewLinks editMode model.links
      , addButton
      ]

viewLinks : Bool -> List LinkModel.Model -> Html Msg
viewLinks editMode links =
  td [] <|
    List.map (lazy2 LinkView.view editMode) links

viewAddButton : Bool -> Html Msg
viewAddButton expanded = 
  div
    [ classList 
      [ ("addButton large", True)
      , ("expanded", expanded)
      ]
    ]
    [ span
      [ class "plus"
      , onClick AddMode
      ]
      [ text "+" ]
    , input
      [ placeholder "Name" 
      , onInput UpdateNameField 
      , onEnter Add
      ] []
    , input
      [ placeholder "Url"
      , onInput UpdateUrlField
      , onEnter Add
      ] []
    ]