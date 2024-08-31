import Data.List

main::IO()
main = do
  print $ recommended [1, 2, 3] bF [(1, 100), (2, 200), (3, 300), (8, 50), (10, 100)] == [10, 8]

bF :: Int -> Int
bF 1 = 3
bF 2 = 10
bF n = 8

recommended :: [Int] -> (Int -> Int) -> [(Int, Int)] -> [Int]
recommended basket bestFit products = 
  filter (\product -> findPrice product <= basketCost && notElem product basket) (map bestFit basket)
    where findPrice product = head [price | (code, price) <- products, code == product]
          basketCost = sum [findPrice prod | prod <- basket]
