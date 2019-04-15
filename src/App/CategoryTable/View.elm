module App.CategoryTable.View exposing ( view )

import Css exposing (..)
import Css.Transitions exposing (transition)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (..)
import Html.Styled.Events exposing (onInput, onClick)

import App.CategoryTable.Model exposing ( Model )
import App.CategoryTable.Messages exposing ( Msg(..) )

import App.CategoryTable.Category.View 

import Utils exposing ( onEnter )

import App.Theme.SharedStyles as Styles
import App.Theme.ColorScheme exposing (Theme, ColorMapping)

view : ColorMapping -> Theme -> Bool -> Model -> Html Msg
view colors theme editMode model = 
    let 
        addButton = 
            tr [] 
                [ td [ colspan 3 ] [ viewAddButton colors theme model.addMode ]] 
        content = 
            viewCategories colors theme editMode model
            |> Utils.appendIf editMode addButton
    in
        Html.Styled.table 
            [ css 
                [ marginRight auto 
                , marginLeft auto 
                , position relative
                ]
            ] 
            content

viewCategories : ColorMapping -> Theme -> Bool -> Model -> List (Html Msg)
viewCategories colors theme editMode model =
    let 
        showCat category = 
            Html.Styled.map 
                (CategoryMsg category.id) 
                ( App.CategoryTable.Category.View.view colors theme editMode category )
    in
        List.map showCat model.categories

viewAddButton : ColorMapping -> Theme -> Bool -> Html Msg
viewAddButton colors theme expanded =
    div
        [ css 
            [ Styles.addButtonStyle colors theme Styles.addButtonWidth expanded ]
        ]
        [ span
            [ class "plus" 
            , onClick AddMode
            , css [ Styles.addButtonSpan colors theme expanded ]
            ]
            [ text "+" ]
        , input
            [ placeholder "Name" 
            , onInput UpdateField
            , onEnter Add
            , css [ Styles.addButtonInput colors theme expanded ]
            ] []
        ]

-- Styles
{-
addButtonStyle : ColorMapping -> Theme -> Float -> Bool -> Style 
addButtonStyle colors theme expandedWidth expanded = 
    let
        buttonWidth = 
            if expanded then px expandedWidth
            else px 30
        
        background = 
            if expanded then 
                Css.batch [ backgroundColor <| colors theme.addButton.expanded.background ]
            else Css.batch []

        hoverStyle = 
            if expanded then 
                Css.batch [ backgroundColor <| colors theme.addButton.expanded.hover.background ]
            else Css.batch [ backgroundColor <| colors theme.addButton.hover.background ]
    in 
        Css.batch   
            [ Styles.circle 30
            , Css.width buttonWidth
            , boxSizing borderBox
            , displayFlex 
            , flexDirection row 
            , padding2 (px 0) (px 10)
            , overflow Css.hidden 
            , background
            , hover 
                [ hoverStyle ]
            , transition
                [ Styles.widthTransition
                , Styles.backgroundTransition 
                ]
            ]
    
addButtonSpan : ColorMapping -> Theme -> Bool -> Style 
addButtonSpan colors theme expanded =
    let 
        textColor = 
            if expanded then theme.addButton.expanded.plusColor 
            else theme.addButton.plusColor 
    in 
        Css.batch 
            [ cursor pointer 
            , fontSize (px 25)
            , marginLeft (px -3)
            , marginRight (px 5)
            , color <| colors textColor
            , transition 
                [ Styles.colorTransition ]
            ]

addButtonInput : ColorMapping -> Theme -> Bool -> Style 
addButtonInput colors theme expanded =
    let 
        expandedStyles =   
            if expanded then 
                Css.batch 
                    [ visibility Css.visible 
                    , display inline 
                    ]
            else 
                Css.batch
                    [ display none 
                    , visibility Css.hidden
                    ]
    in 
        Css.batch 
            [ Css.width (px 140)
            , expandedStyles
            , flexBasis auto
            , padding2 (px 0) (px 10)
            , margin (px 4)
            , backgroundColor <| colors theme.addButton.input.background
            , color <| colors theme.addButton.input.foreground
            , border (px 0) 
            ]
            -}