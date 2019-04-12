module Utils exposing ( flip, onEnter )

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode as Decode exposing (Decoder)

flip : (a -> b -> c) -> b -> a -> c
flip func =
  \b -> \a -> func a b

onEnter : a -> Attribute a
onEnter msg =
  let 
    isEnter code =
      if code == 13 then
        Decode.succeed msg
      else
        Decode.fail "not ENTER"
  in
    on "keydown" (Decode.andThen isEnter keyCode)

