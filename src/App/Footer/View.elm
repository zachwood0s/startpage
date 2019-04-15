module App.Footer.View exposing (view)

import Css exposing (..)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (..)
import Html.Styled.Events exposing (onClick)

import App.Model exposing (Model)
import App.Messages exposing (Msg(..))
import App.Theme.SharedStyles as Styles
import App.Theme.ColorScheme exposing (Theme, ColorMapping)

view : ColorMapping -> Theme -> Model -> Html Msg
view colors theme model = 
  footer 
    [ css [ footerStyle colors theme ]]
    [ viewEdit colors theme model.editMode 
    ]

viewEdit : ColorMapping -> Theme -> Bool -> Html Msg
viewEdit colors theme editMode =
  let 
    iconBackground = 
      if editMode then "base04"
      else "base03"
  in
    div
      [ onClick ToggleEditMode
      , css 
        [ trayIcon colors theme ]
      ] []

-- Styles

footerStyle : ColorMapping -> Theme -> Style 
footerStyle colors theme =
  Css.batch 
    [ position fixed 
    , bottom (px 0)
    , left (px 0)
    , Css.width (pct 100)
    , Css.height (px 50)
    , backgroundColor <| colors theme.footer.background
    , textAlign right 
    ]

trayIcon : ColorMapping -> Theme -> Style 
trayIcon colors theme =
  Css.batch 
    [ Styles.circle 40 
    , position relative 
    , cursor pointer 
    , right (px 20)
    , display inlineBlock
    , backgroundColor <| colors theme.footer.icons.background
    , hover 
      [ backgroundColor <| colors theme.footer.icons.hover.background ]
    ]