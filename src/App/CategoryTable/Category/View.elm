module App.CategoryTable.Category.View exposing ( view )

import Css exposing (..)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (..)
import Html.Styled.Events exposing (onClick, onInput)
import Html.Styled.Lazy exposing (lazy, lazy2)
import Utils exposing (onEnter)
--import Html.Events exposing

import App.CategoryTable.Category.Model exposing ( Model )
import App.CategoryTable.Category.Messages exposing ( Msg(..) )
import App.CategoryTable.Link.Model as LinkModel
import App.CategoryTable.Link.View as LinkView
import App.Theme.ColorScheme exposing (ColorMapping, Theme)
import App.Theme.SharedStyles as Styles 

view : ColorMapping -> Theme -> Bool -> Model -> Html Msg
view colors theme editMode model = 
  let
    title = 
      td
        [ css [ titleStyle ]]
        [ text model.name ]

    removeButton =
        td 
          [ css [ removeButtonStyle colors theme ]
          , onClick RemoveCategory
          ]
          [ text "-" ]
    
    addButton = 
        td [] [ viewAddButton colors theme model.addMode ]

    content = 
      [ title
      , viewLinks colors theme editMode model.links 
      ]
      |> Utils.appendIf editMode addButton 
      |> Utils.consIf editMode removeButton
  in
    tr
      [ css [ categoryStyle colors model.color ]
      ] 
      content


viewLinks : ColorMapping -> Theme -> Bool -> List LinkModel.Model -> Html Msg
viewLinks colors theme editMode links =
  td [] <|
    List.map (LinkView.view colors theme editMode) links

viewAddButton : ColorMapping -> Theme -> Bool -> Html Msg
viewAddButton colors theme expanded = 
  div
    [ css  
      [ Styles.addButtonStyle colors theme Styles.addButtonWidthLarge expanded ]
    ]
    [ span
      [ class "plus"
      , onClick AddMode
      , css [ Styles.addButtonSpan colors theme expanded ]
      ]
      [ text "+" ]
    , input
      [ placeholder "Name" 
      , onInput UpdateNameField 
      , onEnter Add
      , css [ Styles.addButtonInput colors theme expanded ]
      ] []
    , input
      [ placeholder "Url"
      , onInput UpdateUrlField
      , onEnter Add
      , css [ Styles.addButtonInput colors theme expanded ]
      ] []
    ]


-- Styles

categoryStyle : ColorMapping -> String -> Style 
categoryStyle colors categoryColor = 
  Css.batch 
    [ textAlign left 
    , fontSize (px 22)
    , padding (px 5)
    , Css.height (px 30)
    , color <| colors categoryColor
    ]

titleStyle : Style 
titleStyle = 
  Css.batch 
    [ fontWeight bold 
    , color inherit 
    , marginRight (px 10)
    , textAlign right
    , after 
      [ Css.property "content" "'|'"
      , position relative 
      , right (px -5)
      , marginTop (px 1)
      ]
    ]

removeButtonStyle : ColorMapping -> Theme -> Style 
removeButtonStyle colors theme =
  Css.batch 
    [ color <| colors theme.removeButton 
    , cursor pointer 
    , fontWeight bold 
    , textAlign center
    , Styles.circle 30
    , hover 
      [ backgroundColor <| colors theme.addButton.hover.background ]
    ]