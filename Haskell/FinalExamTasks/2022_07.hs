import Data.List

main::IO()
main = do
  print "hello"

maxByLength ls = foldr (\s1 s2 -> if length s1 > length s2 then s1 else s2) [] ls

maxChain chain@(last:rest) amount final dues
 | last == final = chain
 | otherwise = maxByLength [ maxChain (to:chain) amount final dues |
                            (from, due, to) <- dues,
                            amount == due,
                            last == from, notElem to rest]

maxCircle dues = maxByLength [maxChain [receiver] due giver dues | (giver, due, receiver) <- dues]
