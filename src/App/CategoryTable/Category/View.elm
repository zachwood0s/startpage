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
import App.Theme.ColorScheme exposing (WrappedTheme)
import App.Theme.SharedStyles as Styles 

view : WrappedTheme -> Bool -> Model -> Html Msg
view wrapped editMode model = 
  let
    title = 
      td
        [ css [ titleStyle ]]
        [ text model.name ]

    removeButton =
        td 
          [ css [ removeButtonStyle wrapped ]
          , onClick RemoveCategory
          ]
          [ text "-" ]
    
    addButton = 
        td [] [ viewAddButton wrapped model.addMode ]

    content = 
      [ title
      , viewLinks wrapped editMode model.links 
      ]
      |> Utils.appendIf editMode addButton 
      |> Utils.consIf editMode removeButton
  in
    tr
      [ css [ categoryStyle wrapped model.color ]
      ] 
      content


viewLinks : WrappedTheme -> Bool -> List LinkModel.Model -> Html Msg
viewLinks wrapped editMode links =
  td [] <|
    List.map (LinkView.view wrapped editMode) links

viewAddButton : WrappedTheme -> Bool -> Html Msg
viewAddButton wrapped expanded = 
  div
    [ css  
      [ Styles.addButtonStyle wrapped Styles.addButtonWidthLarge expanded ]
    ]
    [ span
      [ class "plus"
      , onClick AddMode
      , css [ Styles.addButtonSpan wrapped expanded ]
      ]
      [ text "+" ]
    , input
      [ placeholder "Name" 
      , onInput UpdateNameField 
      , onEnter Add
      , css [ Styles.addButtonInput wrapped expanded ]
      ] []
    , input
      [ placeholder "Url"
      , onInput UpdateUrlField
      , onEnter Add
      , css [ Styles.addButtonInput wrapped expanded ]
      ] []
    ]


-- Styles

categoryStyle : WrappedTheme -> String -> Style 
categoryStyle wrapped categoryColor = 
  Css.batch 
    [ textAlign left 
    , fontSize (px 22)
    , padding (px 5)
    , Css.height (px 30)
    , color <| wrapped.colors categoryColor
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

removeButtonStyle : WrappedTheme -> Style 
removeButtonStyle wrapped =
  Css.batch 
    [ color <| wrapped.colors wrapped.theme.removeButton 
    , cursor pointer 
    , fontWeight bold 
    , textAlign center
    , Styles.circle 30
    , hover 
      [ backgroundColor <| wrapped.colors wrapped.theme.addButton.hover.background ]
    ]