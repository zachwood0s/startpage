module App.Theme.SharedStyles exposing (..)

import Css exposing (..)
import Css.Transitions exposing (easeInOut, transition)
import App.Theme.ColorScheme exposing (WrappedTheme)

circle : Float -> Style
circle diameter =
  Css.batch 
    [ width (px diameter)
    , height (px diameter)
    , borderRadius (px <| diameter / 2)
    ]

defaultTransitionTime = 300

colorTransition 
  = Css.Transitions.color defaultTransitionTime

backgroundTransition 
  = Css.Transitions.backgroundColor defaultTransitionTime

widthTransition
  = Css.Transitions.width defaultTransitionTime

addButtonWidthLarge = 375
addButtonWidth = 222

addButtonStyle : WrappedTheme -> Float -> Bool -> Style 
addButtonStyle wrapped expandedWidth expanded = 
  let
    buttonWidth = 
      if expanded then px expandedWidth
      else px 30
    
    background = 
      if expanded then 
        Css.batch [ backgroundColor <| wrapped.colors wrapped.theme.addButton.expanded.background ]
      else Css.batch []

    hoverStyle = 
      if expanded then 
        Css.batch [ backgroundColor <| wrapped.colors wrapped.theme.addButton.expanded.hover.background ]
      else Css.batch [ backgroundColor <| wrapped.colors wrapped.theme.addButton.hover.background ]
  in 
    Css.batch   
      [ circle 30
      , Css.width buttonWidth
      , position relative
      , boxSizing borderBox
      , displayFlex 
      , flexDirection row 
      , padding2 (px 0) (px 10)
      , overflow Css.hidden 
      , background
      , hover 
        [ hoverStyle ]
      , transition
        [ widthTransition
        , backgroundTransition 
        ]
      ]
    
addButtonSpan : WrappedTheme -> Bool -> Style 
addButtonSpan wrapped expanded =
  let 
    textColor = 
      if expanded then wrapped.theme.addButton.expanded.plusColor 
      else wrapped.theme.addButton.plusColor 
  in 
    Css.batch 
      [ cursor pointer 
      , fontSize (px 25)
      , marginLeft (px -3)
      , marginRight (px 5)
      , color <| wrapped.colors textColor
      , transition 
        [ colorTransition ]
      ]

addButtonInput : WrappedTheme -> Bool -> Style 
addButtonInput wrapped expanded =
  let 
    expandedStyles =   
      if expanded then 
        Css.batch 
          [ visibility Css.visible 
          , display inline 
          ]
      else 
        Css.batch
          [ display none 
          , visibility Css.hidden
          ]
  in 
    Css.batch 
      [ Css.width (px 140)
      , expandedStyles
      , flexBasis auto
      , padding2 (px 0) (px 10)
      , margin (px 4)
      , backgroundColor <| wrapped.colors wrapped.theme.addButton.input.background
      , color <| wrapped.colors wrapped.theme.addButton.input.foreground
      , border (px 0) 
      ]