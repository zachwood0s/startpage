module App.Messages exposing ( Msg(..) ) 

import App.CategoryTable.Messages
import App.Footer.Messages

type Msg 
    = NoOp
    | ToggleEditMode
    | CategoryTableMsg App.CategoryTable.Messages.Msg
    | FooterMsg App.Footer.Messages.Msg
    
