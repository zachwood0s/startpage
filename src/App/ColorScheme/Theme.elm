module App.Theme exposing (Theme)

import Dict

type ThemeColor = ThemeColor String String

initThemeColors : Enum ThemeColor
initThemeColors = 
  { values = 
    [ ThemeColor "Background"
    , ThemeColor "Accent1"
    , ThemeColor "Accent2"
    , ThemeColor "Accent3"
    , ThemeColor "Accent4"
    ]
  , toString = \(ThemeColor name _) -> name
  }

type alias Theme = 
  { background :  }

