module Utils exposing ( flip, onEnter, consIf, appendIf, strConsIf, strAppendIf)

import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (..)
import Html.Styled.Events exposing (..)
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

consIf : Bool -> a -> List a -> List a
consIf shouldAdd x xs =
  if shouldAdd then 
    x :: xs 
  else 
    xs

appendIf : Bool -> a -> List a -> List a 
appendIf shouldAdd elm list =
  if shouldAdd then 
    list ++ [elm]
  else 
    list

strConsIf : Bool -> Char -> String -> String
strConsIf shouldAdd x xs =
  if shouldAdd then 
    String.cons x xs 
  else 
    xs

strAppendIf : Bool -> String -> String -> String 
strAppendIf shouldAdd x xs =
  if shouldAdd then 
    String.append xs x
  else 
    xs
