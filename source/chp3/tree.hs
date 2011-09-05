-- file: chp3/tree.hs

data Tree a = Node a (Tree a) (Tree a)
            | Empty
              deriving (Show)
