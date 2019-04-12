module App.ColorScheme.Base16 exposing (Base16Color(..))

import Utils exposing (Enum)

type alias Base16 = Enum Base16Color
type Base16Color = Base16Color String

base16ColorToString : Base16Color -> String
base16ColorToString (Base16Color name) = name



