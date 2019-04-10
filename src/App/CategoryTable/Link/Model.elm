module App.CategoryTable.Link.Model exposing (Model, newLink)

type alias Model =
    { name : String
    , url : String
    , id : Int
    }

newLink : String -> String -> Int -> Model
newLink name url id = 
    Model name url id