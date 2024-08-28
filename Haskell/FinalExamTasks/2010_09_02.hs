import Data.List

main :: IO()
main = do
  print $ sumProd [[2, 3, 4], [2, -1, 4], [1]]

sumProd :: [[Int]] -> Int
sumProd ll = sum $ map product $ filter (all (>0)) ll
