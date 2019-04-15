module App.Footer.Model exposing (Model)

import Time

type alias Model = 
  { time : Time.Posix
  , zone : Time.Zone
  }