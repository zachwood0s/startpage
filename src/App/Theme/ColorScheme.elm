module App.Theme.ColorScheme exposing (Theme, initTheme, ColorMap, ColorMapping, initColorMap, fromColorMap, mapSelector)

import Dict exposing (Dict)
import Css exposing (..)

type alias ColorMap = Dict String String

defaultColorMap =
  Dict.fromList 
    [ ("base00", "2d2d2d")
    , ("base01", "393939")
    , ("base02", "515151")
    , ("base03", "747369")
    , ("base04", "a09f93")
    , ("base05", "d3d0c8")
    , ("base06", "e8e6df")
    , ("base07", "f2f0ec")
    , ("base08", "f2777a")
    , ("base09", "f99157")
    , ("base10", "ffcc66")
    , ("base11", "99cc99")
    , ("base12", "66cccc")
    , ("base13", "6688cc")
    , ("base14", "cc99cc")
    , ("base15", "d27b53")
    ]

initColorMap : Maybe ColorMap -> ColorMap
initColorMap map =
  Maybe.withDefault defaultColorMap map

type alias Theme = 
  { background : String
  , foreground : String
  , title : String
  , addButton : 
    { background : String
    , foreground : String 
    , input : 
      { background : String 
      , foreground : String 
      }
    , plusColor : String
    , hover : 
      { background : String }
    , expanded : 
      { background : String 
      , plusColor : String
      , hover : 
        { background : String }
      }
    }
    , removeButton : String
    , links : String
  , footer :  
    { background : String 
    , icons : 
      { background : String 
      , hover : 
        { background : String }
      }
    , clockColor : String
    }
  }

defaultTheme : Theme
defaultTheme =
  { background = "base00"
  , foreground = "base01"
  , title = "base06"
  , addButton = 
    { background = "base00"
    , foreground = "base03"
    , input = 
      { background = "base01"
      , foreground = "base05"
      }
    , plusColor = "base03"
    , hover = 
      { background = "base01" }
    , expanded = 
      { background = "base03" 
      , plusColor = "base00"
      , hover = 
        { background = "base03" }
      }
    }
  , removeButton = "base03"
  , links = "base06"
  , footer = 
    { background = "base00"
    , icons = 
      { background = "base03"
      , hover = 
        { background = "base02" }
      }
    , clockColor = "base03"
    }
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

type alias ColorMapping = (String -> Color)

mapSelector : ColorMap -> ColorMapping
mapSelector map = \c -> hex <| fromColorMap c map
