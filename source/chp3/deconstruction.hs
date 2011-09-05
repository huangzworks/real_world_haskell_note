-- file: chp3/deconstruction.hs

type Id = Int
type Title = String
type Authors = [String]

data Book = Book Id Title Authors 
            deriving (Show)

bookId (Book id title authors) = id
bookTitle (Book id title authors) = title
bookAuthors (Book id title authors) = authors
