import Data.List

main::IO()
main = do
  print $ filterByChar 'o' ["cat", "cow", "dog"]
  print $ let (x:y):z = ["Curry"] in (x,y,z)
  print $ let (x:y):z = ["Curry", "sdfsd", "sfdsdf"] in (x, y, z)

filterByChar c ls = filter (\x -> elem c x) ls
