module App.Model exposing (..)

type alias Model =
  { storedModel : StoredModel
  , editMode : Bool 
  }

type alias StoredModel = 
  { categories : List Category
  , greeting : String 
  , uid : Int
  }

type alias Category = 
  { name : String
  , color : String
  , links : List Link
  , id : Int
  }

type alias Link =
  { name : String
  , link : String
  }

newCategory : String -> String -> Int -> Category
newCategory name color id =
  { name = name
  , color = color
  , links = []
  , id = id 
  }

