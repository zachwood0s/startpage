module App.CategoryTable.View exposing ( view )

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)

import App.CategoryTable.Model exposing ( Model )
import App.CategoryTable.Messages exposing ( Msg(..) )

import Utils exposing ( onEnter )

view : Bool -> Model -> Html Msg
view editMode model = 
    let 
        addButton = 
            if editMode then 
                tr [] 
                   [ td [ colspan 3 ] [ viewAddButton model.addMode ]] 
            else text ""
    in
        table [ id "links" ] [ addButton ]


viewAddButton : Bool -> Html Msg
viewAddButton expanded =
    div
        [ classList
            [ ("addButton", True)
            , ("expanded", expanded)
            ]
        ]
        [ span
            [ class "plus" 
            , onClick AddMode
            ]
            [ text "+" ]
        , input
            [ placeholder "Name" 
            , onInput UpdateField
            , onEnter Add
            ] []
        ]


