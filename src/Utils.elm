
flip : (a -> b -> c) -> b -> a -> c
flip func =
  \b -> \a -> func a b