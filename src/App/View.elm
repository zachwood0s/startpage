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

import App.Theme.ColorScheme exposing (ColorMapping, Theme)

view : Model -> Browser.Document Msg
view model = 
    let 
        unstyled = viewBody colors >> toUnstyled
        colors = App.Theme.ColorScheme.mapSelector model.colorMap 
    in 
        { title = "New Tab test"
        , body = [ unstyled model ]
        }


viewBody : ColorMapping -> Model -> Html Msg
viewBody colors model =
    section 
        [ css 
            [ backgroundColor <| colors model.theme.background 
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
            [ viewGreeting colors model.theme model.storedModel.greeting
            , Html.Styled.map CategoryTableMsg 
                (App.CategoryTable.View.view colors model.theme model.editMode model.storedModel.categoryTable )
            , App.Footer.View.view colors model.theme model
            ]
        ]


viewGreeting : ColorMapping -> Theme -> String -> Html Msg
viewGreeting colors theme greeting = 
    h1 
        [ css 
            [ greetingFont 
            , color <| colors theme.title]
        ] 
        [ text greeting ]


-- Styles

greetingFont : Style
greetingFont = 
    Css.batch 
        [ fontFamilies ["Yellowtail", "cursive"]
        , fontSize (px 100)
        ]