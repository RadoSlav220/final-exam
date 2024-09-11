import Data.List

main::IO()
main = do
  print $ myunion [1,3,4] [4,1,7] \\ [3,4,1,7] == []
  print $ subset [1,2] [3,2,1] == True
  print $ collect clicks ["a", "b", "c"] \\ [1,2,3,5,7] == []
  print $ redundant clicks ["a", "b", "c"] == ["a", "b"]

clicks "a" = [1,2,3] 
clicks "b" = [1,3,5]
clicks "c" = [2,3,5,7]

myunion xs ys = nub $ xs ++ ys

subset xs ys = all (\x -> x `elem` ys) xs

collect clicks ads = foldr (\ad acc -> myunion acc (clicks ad)) [] ads

redundant clicks ads = filter (\ad -> subset (clicks ad) 
                              (collect clicks [a | a <- ads, a /= ad])) ads