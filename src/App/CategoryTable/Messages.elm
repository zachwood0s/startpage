module App.CategoryTable.Messages exposing (Msg(..))

import App.CategoryTable.Category.Messages as CategoryMsg

type Msg 
    = NoOp
    | UpdateField String
    | Add
    | AddMode
    | CategoryMsg Int CategoryMsg.Msg

