module App.CategoryTable.View exposing ( view )

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)

import App.CategoryTable.Model exposing ( Model )
import App.CategoryTable.Messages exposing ( Msg(..) )

import App.CategoryTable.Category.View 

import Utils exposing ( onEnter )

view : Bool -> Model -> Html Msg
view editMode model = 
    let 
        addButton = 
            if editMode then 
                tr [] 
                   [ td [ colspan 3 ] [ viewAddButton model.addMode ]] 
            else text ""
        content = (viewCategories editMode model) ++ [ addButton ]
    in
        table 
            [ id "links" ] 
            content

viewCategories : Bool -> Model -> List (Html Msg)
viewCategories editMode model =
    let 
        showCat category = 
            Html.map (CategoryMsg category.id) ( App.CategoryTable.Category.View.view editMode category )
    in
        List.map showCat model.categories

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


