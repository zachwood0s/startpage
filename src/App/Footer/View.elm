module App.Footer.View exposing (view)

import Css exposing (..)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (..)
import Html.Styled.Events exposing (onClick)
import Time

import App.Footer.Model exposing (Model)
import App.Messages exposing (Msg(..))
import App.Theme.SharedStyles as Styles
import App.Theme.ColorScheme exposing (Theme, ColorMapping)
import Utils

view : ColorMapping -> Theme -> Bool -> Model -> Html Msg
view colors theme editMode model = 
  footer 
    [ css [ footerStyle colors theme ]]
    [ viewTime colors theme model.time model.zone
    , viewEdit colors theme editMode 
    ]

viewTime : ColorMapping -> Theme -> Time.Posix -> Time.Zone -> Html Msg
viewTime colors theme time zone =
  let 
    hour = Time.toHour zone time 
    minute = Time.toMinute zone time 

    printedHour = 
      String.fromInt hour 
      |> Utils.strConsIf (hour < 10) '0' 

    printedMinute = 
      String.fromInt minute 
      |> Utils.strConsIf (minute < 10) '0'

  in
    div 
      [ css [ clockStyle colors theme ] ]
      [ text (printedHour ++ ":" ++ printedMinute) ]


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

clockStyle : ColorMapping -> Theme -> Style 
clockStyle colors theme =
  Css.batch 
    [ position absolute 
    , left (px 20)
    , fontSize (px 40)
    , color <| colors theme.footer.clockColor
    ]

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
