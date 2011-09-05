-- file: chp3/guard.hs

greet :: String -> String

greet value
    | value == "hello"        = "hello"
    | value == "good morning" = "morning"
    | otherwise               = "hello"
