-- file: chp3/deconstruction.hs

type Id = Int
type Title = String
type Authors = [String]

data Book = Book Id Title Authors 
            deriving (Show)

bookId (Book id _ _) = id
bookTitle (Book _ title _) = title
bookAuthors (Book _ _ authors) = authors
