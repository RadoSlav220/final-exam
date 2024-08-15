import Data.List
import Data.Char

main :: IO()
main = do
  print $ countOccurrences "Test" == [('e',1),('s',1),('t',2)]
  print $ countOccurrences "ThisIsAReallyLongWordContaingAlmostEveryCharacter" == [('a',6),('c',3),('d',1),('e',4),('g',2),('h',2),('i',3),('l',4),('m',1),('n',3),('o',4),('r',5),('s',3),('t',4),('v',1),('w',1),('y',2)]

-- countOccurrences :: [Char] -> [(Char, Int)]
-- countOccurrences xs = nub $ [(toLower x, singleCount x) | x <- xs]
--   where
--     singleCount x = length $ filter (\ c -> toLower c == toLower x) xs

countOccurrences :: String -> [(Char, Int)]
countOccurrences ss = map (\ grp -> (head grp, length grp)) $ group $ sort $ map toLower ss
