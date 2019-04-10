module App.View exposing (view)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Browser.Dom as Dom
import App.Model exposing (Model)
import App.Messages exposing (Msg(..))
import App.CategoryTable.View
import App.Footer.View

view : Model -> Browser.Document Msg
view model = 
    { title = "New Tab test"
    , body = [ viewBody model ]
    }


viewBody : Model -> Html Msg
viewBody model =
    div 
        [ class "content" ] 
        [ viewGreeting model.storedModel.greeting
        , Html.map CategoryTableMsg 
            (App.CategoryTable.View.view model.editMode model.storedModel.categoryTable )
        , App.Footer.View.view model
        ]


viewGreeting : String -> Html Msg
viewGreeting greeting = 
    h1 [] [ text greeting ]
