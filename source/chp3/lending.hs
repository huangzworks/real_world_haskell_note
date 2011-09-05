-- file: chp3/lending.hs

lend amount balance = let reverse = 100
                          newBalance = balance - amount
                      in if balance < reverse
                         then Nothing
                         else Just newBalance
