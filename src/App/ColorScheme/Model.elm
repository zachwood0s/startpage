module App.ColorScheme.Model exposing (Theme)

import App.ColorScheme.Base16 exposing (Base16)

type alias Theme = 
  { background : Base16
  , textColor : Base16
  , lighterBackground : Base16
  }

