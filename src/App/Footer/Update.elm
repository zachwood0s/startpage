module App.Footer.Update exposing (update)

import App.Footer.Messages exposing (Msg(..))
import App.Footer.Model exposing (Model)

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        OnTime t ->
          ( { model | time = t }
          , Cmd.none 
          )

        AdjustTimeZone newZone -> 
          ( { model | zone = newZone }
          , Cmd.none 
          )
            
