module App.Messages exposing ( Msg(..) ) 

import App.CategoryTable.Messages

type Msg 
    = NoOp
    | ToggleEditMode
    | CategoryTableMsg App.CategoryTable.Messages.Msg
    
