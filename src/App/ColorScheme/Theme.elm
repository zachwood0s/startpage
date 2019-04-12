module App.ColorScheme.Theme exposing (Theme, initTheme, ColorMap, initColorMap, fromColorMap)

import Dict exposing (Dict)

type alias ColorMap = Dict String String

defaultColorMap =
  Dict.fromList 
    [ ("base00", "2d2d2d")
    , ("base01", "393939")
    ]

initColorMap : Maybe ColorMap -> ColorMap
initColorMap map =
  Maybe.withDefault defaultColorMap map

type alias Theme = 
  { background : String
  , foreground : String
  }

defaultTheme : Theme
defaultTheme =
  { background = "base00"
  , foreground = "base01"
  }

initTheme : Maybe Theme -> Theme
initTheme theme =
  Maybe.withDefault defaultTheme theme

defaultColor = "000000"

fromColorMap : String -> ColorMap -> String
fromColorMap value map =
  case Dict.get value map of
    Just color -> color
    Nothing -> defaultColor

mapSelector : ColorMap -> (String -> String)
mapSelector map = \c -> fromColorMap c map
