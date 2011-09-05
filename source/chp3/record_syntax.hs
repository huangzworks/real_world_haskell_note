-- file: chp3/record_syntax.hs

type Id = Int
type Title = String
type Authors = [String]

data Book = Book {
                bookId :: Id,
                bookTitle :: Title,
                bookAuthors :: Authors 
            } deriving (Show)
