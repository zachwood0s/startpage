module App.Messages exposing ( Msg(..) ) 

import App.CategoryTable.Messages

type Msg 
    = NoOp
    | CategoryTableMsg App.CategoryTable.Messages.Msg
    
