module App.Footer.View exposing (view)

import Css exposing (..)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (..)
import Html.Styled.Events exposing (onClick)
import Time

import App.Footer.Model exposing (Model)
import App.Messages exposing (Msg(..))
import App.Theme.SharedStyles as Styles
import App.Theme.ColorScheme exposing (WrappedTheme)
import Utils

view : WrappedTheme -> Bool -> Model -> Html Msg
view wrapped editMode model = 
  footer 
    [ css [ footerStyle wrapped ]]
    [ viewTime wrapped model.time model.zone
    , viewEdit wrapped editMode 
    ]

viewTime : WrappedTheme -> Time.Posix -> Time.Zone -> Html Msg
viewTime wrapped time zone =
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
      [ css [ clockStyle wrapped ] ]
      [ text (printedHour ++ ":" ++ printedMinute) ]


viewEdit : WrappedTheme -> Bool -> Html Msg
viewEdit wrapped editMode =
  let 
    iconBackground = 
      if editMode then "base04"
      else "base03"
  in
    div
      [ onClick ToggleEditMode
      , css 
        [ trayIcon wrapped ]
      ] []

-- Styles

clockStyle : WrappedTheme -> Style 
clockStyle wrapped =
  Css.batch 
    [ position absolute 
    , left (px 20)
    , fontSize (px 40)
    , color <| wrapped.colors wrapped.theme.footer.clockColor
    ]

footerStyle : WrappedTheme -> Style 
footerStyle wrapped =
  Css.batch 
    [ position fixed 
    , bottom (px 0)
    , left (px 0)
    , Css.width (pct 100)
    , Css.height (px 50)
    , backgroundColor <| wrapped.colors wrapped.theme.footer.background
    , textAlign right 
    ]

trayIcon : WrappedTheme -> Style 
trayIcon wrapped =
  Css.batch 
    [ Styles.circle 40 
    , position relative 
    , cursor pointer 
    , top (px 5)
    , right (px 20)
    , display inlineBlock
    , backgroundColor <| wrapped.colors wrapped.theme.footer.icons.background
    , hover 
      [ backgroundColor <| wrapped.colors wrapped.theme.footer.icons.hover.background ]
    ]
