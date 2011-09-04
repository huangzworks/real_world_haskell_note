-- file: chp3/BookStore_version_2.hs

type Id = Int
type Title = String
type Authors = [String]

data BookInfo = Book Id Title Authors
                deriving (Show)
