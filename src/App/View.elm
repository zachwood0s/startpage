module App.View exposing (view)

import Browser
import Css exposing (..)
import Html.Styled exposing(..)
import Html.Styled.Attributes exposing (..)
import Browser.Dom as Dom
import App.Model exposing (Model)
import App.Messages exposing (Msg(..))
import App.CategoryTable.View
import App.Footer.View

import App.Theme.ColorScheme exposing (WrappedTheme)

view : Model -> Browser.Document Msg
view model = 
    let 
        colors = App.Theme.ColorScheme.mapSelector model.colorMap 
        wrappedTheme = WrappedTheme model.theme model.colorMap colors
        unstyled = viewBody wrappedTheme >> toUnstyled
    in 
        { title = "New Tab test"
        , body = [ unstyled model ]
        }


viewBody : WrappedTheme -> Model -> Html Msg
viewBody wrapped model =
    section 
        [ css 
            [ backgroundColor <| wrapped.colors model.theme.background 
            , position absolute
            , Css.width (pct 100)
            , Css.height (pct 100)
            , fontFamilies ["Fira Mono", "monospace"]
            ]
        ]
        [ div 
            [ css 
                [ Css.width (pct 50)
                , marginLeft auto 
                , marginRight auto 
                , textAlign center 
                ]
            ] 
            [ viewGreeting wrapped model.storedModel.greeting
            , Html.Styled.map CategoryTableMsg 
                (App.CategoryTable.View.view wrapped model.editMode model.storedModel.categoryTable )
            , App.Footer.View.view wrapped model.editMode model.footerModel
            ]
        ]


viewGreeting : WrappedTheme -> String -> Html Msg
viewGreeting wrapped greeting = 
    h1 
        [ css 
            [ greetingFont 
            , color <| wrapped.colors wrapped.theme.title]
        ] 
        [ text greeting ]


-- Styles

greetingFont : Style
greetingFont = 
    Css.batch 
        [ fontFamilies ["Yellowtail", "cursive"]
        , fontSize (px 100)
        ]
