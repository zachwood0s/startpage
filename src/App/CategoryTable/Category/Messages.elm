module App.CategoryTable.Category.Messages exposing ( Msg(..) )

type Msg 
    = NoOp
    | Add
    | AddMode
    | UpdateUrlField String
    | UpdateNameField String
    | RemoveCategory