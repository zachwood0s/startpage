module App.Footer.Model exposing (Model, emptyModel, init)

import Time
import Task

import App.Footer.Messages exposing (Msg(..))

type alias Model = 
  { time : Time.Posix
  , zone : Time.Zone
  }


emptyModel : Model 
emptyModel =
  { time = Time.millisToPosix 0 
  , zone = Time.utc 
  }

init : ( Model, Cmd Msg )
init = 
  ( emptyModel 
  , Task.perform AdjustTimeZone Time.here 
  )
