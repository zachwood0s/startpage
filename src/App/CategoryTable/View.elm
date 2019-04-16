module App.CategoryTable.View exposing ( view )

import Css exposing (..)
import Css.Transitions exposing (transition)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (..)
import Html.Styled.Events exposing (onInput, onClick)
import Dict

import App.CategoryTable.Model exposing ( Model )
import App.CategoryTable.Messages exposing ( Msg(..) )
import App.CategoryTable.Category.View 
import App.Theme.SharedStyles as Styles
import App.Theme.ColorScheme exposing (WrappedTheme)
import Utils exposing ( onEnter )

view : WrappedTheme -> Bool -> Model -> Html Msg
view wrapped editMode model = 
    let 
        addButton = 
            tr [] 
                [ td [ colspan 3 ] [ viewAddButton wrapped model ]] 
        content = 
            viewCategories wrapped editMode model
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

viewCategories : WrappedTheme -> Bool -> Model -> List (Html Msg)
viewCategories wrapped editMode model =
    let 
        showCat category = 
            Html.Styled.map 
                (CategoryMsg category.id) 
                ( App.CategoryTable.Category.View.view wrapped editMode category )
    in
        List.map showCat model.categories

viewAddButton : WrappedTheme -> Model -> Html Msg
viewAddButton wrapped model =
    let 
        addButtonWidth = 
            if model.colorMode then 300
            else Styles.addButtonWidth 

        content = 
            [ span
                [ class "plus" 
                , onClick AddMode
                , css [ Styles.addButtonSpan wrapped model.addMode ]
                ]
                [ text "+" ]
            , input
                [ placeholder "Name" 
                , onInput UpdateField
                , onEnter Add
                , css [ Styles.addButtonInput wrapped model.addMode ]
                ] []
            ]
            |> Utils.consIf model.addMode (viewColorSelector wrapped model)
    in 
        div
            [ css 
                [ Styles.addButtonStyle wrapped addButtonWidth model.addMode ]
            ]
            content

viewColorSelector : WrappedTheme -> Model -> Html Msg
viewColorSelector wrapped model =
    let 
        accentColors = 
            List.filter (String.startsWith "accent") (Dict.keys wrapped.colorMap)

        defaultColor =
            accentColors 
            |> List.head
            |> Maybe.withDefault "accent00"

        selectorStyle = 
            [ colorSelectorStyle wrapped ]
            |> Utils.appendIf model.colorMode 
                (colorSelectorStyleExpanded <| List.length accentColors)
        
        content = 
            if not model.colorMode then 
                [ span 
                    [ css 
                        [ colorItemStyle 
                        , backgroundColor <| wrapped.colors model.selectedColor
                        ]
                    , onClick EnterColorMode
                    ]
                    []
                ]
            else 
                List.map (viewColorItem wrapped) accentColors
    in
        div 
            [ css selectorStyle ] 
            content

viewColorItem : WrappedTheme -> String -> Html Msg
viewColorItem wrapped color = 
    span 
        [ css 
            [ colorItemStyle
            , backgroundColor <| wrapped.colors color 
            , marginLeft (px colorItemSpacing)
            ]
        , onClick (UpdateColor color)
        ]
        []

-- Styles 

colorItemDiameter = 20.0
colorItemSpacing = 4.0

colorSelectorStyleExpanded : Int -> Style
colorSelectorStyleExpanded itemCount =
    let 
        totalItemWidth = (toFloat itemCount) * colorItemDiameter
        spacingWidth = (toFloat (itemCount - 1)) * colorItemSpacing
        expandedWidth = spacingWidth + totalItemWidth
    in
        Css.batch 
            [ Css.width (px expandedWidth)]

colorSelectorStyle : WrappedTheme -> Style 
colorSelectorStyle wrapped =
    Css.batch 
        [ position absolute 
        , right (px 0)
        , top (px 0)
        , Styles.circle 30 
        , backgroundColor <| wrapped.colors wrapped.theme.addButton.expanded.background
        , transition 
            [ Styles.widthTransition ]
        ]

colorItemStyle : Style 
colorItemStyle =
    Css.batch 
        [ Styles.circle colorItemDiameter 
        , display inlineBlock
        , marginTop (px 5)
        , cursor pointer
        ]

