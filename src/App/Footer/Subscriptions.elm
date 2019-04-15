module App.Footer.Subscriptions exposing (subscriptions)

import Time

import App.Footer.Model exposing (Model)
import App.Footer.Messages exposing (Msg(..))

subscriptions : Model -> Sub Msg
subscriptions model =
  Time.every 1000 OnTime