module Main exposing (..)

import Browser
import App.Model exposing (Flags, StoredModel, Model, init)
import App.Messages exposing (Msg)
import App.Update exposing (updateWithStorage)
import App.View exposing (view)
import App.Subscriptions exposing (subscriptions)

main : Program (Maybe StoredModel) Model Msg
main =
  Browser.document
    { init = init
    , view = view
    , update = updateWithStorage
    , subscriptions = subscriptions
    }
