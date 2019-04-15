module App.Footer.Messages exposing (Msg)

import Time

type Msg
    = NoOp
    | OnTime Time.Posix
    | AdjustTimeZone Time.Zone