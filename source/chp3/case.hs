-- file: chp3/case.hs

greet :: String -> String
greet value = case value of
                "hello" -> "world"
                "good morninig" -> "morninig"
                _ -> "hello"
