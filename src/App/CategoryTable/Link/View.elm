module App.CategoryTable.Link.View exposing (view)

import Css exposing (..)
import Css.Transitions exposing (transition)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (..)
import Html.Styled.Events exposing (onClick)

import App.CategoryTable.Category.Messages exposing ( Msg(..) )
import App.CategoryTable.Link.Model exposing (Model)

import App.Theme.ColorScheme exposing (ColorMapping, Theme)
import App.Theme.SharedStyles as Styles
import Utils

view : ColorMapping -> Theme -> Bool -> Model -> Html Msg
view colors theme editMode model = 
  let 
    linkAttr =
      if editMode then
        [ onClick (RemoveLink model.id)
        , href "#"
        ]
      else [ href model.url ]

    attributes = css [ aStyle colors theme ] :: linkAttr 
  in
    a 
      attributes
      [ span
        [ css
          [ linkStyles colors theme editMode ]
        ]
        [ text model.name ]
      ]


linkStyles : ColorMapping -> Theme -> Bool -> Style
linkStyles colors theme editMode =
  let 
    crossOut = 
      if editMode then 
        Css.batch 
          [ Css.property "content" "''"
          , position absolute 
          , display block 
          , left (px 0)
          , top (px 13)
          , Css.height (px 4)
          , Css.width (px 0)
          , backgroundColor <| colors theme.links
          , transition 
            [ Styles.widthTransition ]
          , hover 
            [ before [ Css.width (pct 100) ]]
          ]
      else Css.batch []
  in 
    Css.batch 
      [ color <| colors theme.links 
      , padding2 (px 0) (px 10)
      , position relative
      , cursor pointer 
      , before 
        [ crossOut ]
      , hover 
        [ color inherit ]
      , transition 
        [ Styles.colorTransition ]
      ]

aStyle : ColorMapping -> Theme -> Style
aStyle colors theme = 
  Css.batch 
    [ after 
      [ Css.property "content" "'|'"
      , position relative 
      , left (px 0)
      , marginTop (px -2)
      , color <| colors theme.links 
      ]
    , lastChild 
      [ after 
        [ Css.property "content" "''" ]
      ]
    ]