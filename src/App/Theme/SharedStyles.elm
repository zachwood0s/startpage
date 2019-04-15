module App.Theme.SharedStyles exposing (..)

import Css exposing (..)
import Css.Transitions exposing (easeInOut, transition)
import App.Theme.ColorScheme exposing (ColorMapping, Theme)

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
addButtonWidth = 210

addButtonStyle : ColorMapping -> Theme -> Float -> Bool -> Style 
addButtonStyle colors theme expandedWidth expanded = 
  let
    buttonWidth = 
      if expanded then px expandedWidth
      else px 30
    
    background = 
      if expanded then 
        Css.batch [ backgroundColor <| colors theme.addButton.expanded.background ]
      else Css.batch []

    hoverStyle = 
      if expanded then 
        Css.batch [ backgroundColor <| colors theme.addButton.expanded.hover.background ]
      else Css.batch [ backgroundColor <| colors theme.addButton.hover.background ]
  in 
    Css.batch   
      [ circle 30
      , Css.width buttonWidth
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
    
addButtonSpan : ColorMapping -> Theme -> Bool -> Style 
addButtonSpan colors theme expanded =
  let 
    textColor = 
      if expanded then theme.addButton.expanded.plusColor 
      else theme.addButton.plusColor 
  in 
    Css.batch 
      [ cursor pointer 
      , fontSize (px 25)
      , marginLeft (px -3)
      , marginRight (px 5)
      , color <| colors textColor
      , transition 
        [ colorTransition ]
      ]

addButtonInput : ColorMapping -> Theme -> Bool -> Style 
addButtonInput colors theme expanded =
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
      , backgroundColor <| colors theme.addButton.input.background
      , color <| colors theme.addButton.input.foreground
      , border (px 0) 
      ]