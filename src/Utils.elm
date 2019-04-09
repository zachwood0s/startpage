module Utils exposing ( flip, onEnter )

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode as Json

flip : (a -> b -> c) -> b -> a -> c
flip func =
  \b -> \a -> func a b

onEnter : a -> Attribute a
onEnter msg =
  let 
    isEnter code =
      if code == 13 then
        Json.succeed msg
      else
        Json.fail "not ENTER"
  in
    on "keydown" (Json.andThen isEnter keyCode)
