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


type alias Enum a = 
  { values : List a
  , toString : a -> String
  }

findEnumValue : Enum a -> String -> Maybe a
findEnumValue enum value =
  enum.values
  |> List.filter ((==) value << enum.toString )
  |> List.head

decodeEnumValue : Enum a -> String -> Decoder a
decodeEnumValue enum stringValue =
  case findEnumValue stringValue of 
    Just value -> Decode.succeed value
    Nothing -> Decode.fail <| "Could not decode value to enum: "++stringValue
