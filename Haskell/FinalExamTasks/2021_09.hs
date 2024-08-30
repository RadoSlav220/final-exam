import Data.List

main::IO()
main = do
  print $ filter (`elem` [10..20]) [1,5,10,100,20,15]
  print $ negate $ max 10 20
  print (take 4 [1,3..])
  print $ g [[1,2,3],[4,5,6]]
  print x
  print $ map ($ 0) (map (-) [1..5])
  print $ f [1, 10]

x = (:[[1]]) []

f l = [ x+y | x <- l, y <- l]

g :: Num t => [[t]] -> [[t]]
g ([]:_) = []
g x = (map head x) : g (map tail x)
