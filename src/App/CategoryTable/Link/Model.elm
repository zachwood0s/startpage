module App.CategoryTable.Link.Model exposing (Model, newLink)

type alias Model =
    { name : String
    , url : String
    }

newLink : String -> String -> Model
newLink name url = 
    Model name url