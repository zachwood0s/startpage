module Utils exposing ( flip, onEnter )

import Html.Attributes exposing (..)

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
