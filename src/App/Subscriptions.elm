module App.Subscriptions exposing (subscriptions)

import App.Model exposing (Model)
import App.Messages exposing (..)
import App.Footer.Subscriptions

subscriptions : Model -> Sub Msg
subscriptions model =
   Sub.map FooterMsg (App.Footer.Subscriptions.subscriptions model.footerModel)
