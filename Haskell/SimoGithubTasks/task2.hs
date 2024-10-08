import System.IO
import Data.Char
import Data.List

main :: IO()
main = do
  print $ numberBTree
  print $ charBTree

  print $ size numberBTree == 9
  print $ size charBTree == 7

  print $ sumTree numberBTree == 146
  -- print $ sumTree charBTree -- should not work

  print $ traverseDFS numberBTree == [96, 1, 12, 0, 5, 2, 4, 5, 21]
  print $ traverseDFS charBTree == "haskell"

  print $ getLevel numberBTree 2 == [1, 0, 2, 5]
  print $ getLevel charBTree 1 == "al"
  print $ getLevel charBTree 3 == []

  print $ traverseBFS numberBTree == [5,12,4,1,0,2,5,96,21]
  print $ traverseBFS charBTree == "kalhsel"

  print $ mapTree numberBTree (*2) == Node 10 (Node 24 (Node 2 (Node 192 Nil Nil) Nil) (Node 0 Nil Nil)) (Node 8 (Node 4 Nil Nil) (Node 10 Nil (Node 42 Nil Nil)))
  print $ mapTree numberBTree (show) == Node "5" (Node "12" (Node "1" (Node "96" Nil Nil) Nil) (Node "0" Nil Nil)) (Node "4" (Node "2" Nil Nil) (Node "5" Nil (Node "21" Nil Nil)))
  print $ mapTree charBTree (toUpper) == Node 'K' (Node 'A' (Node 'H' Nil Nil) (Node 'S' Nil Nil)) (Node 'L' (Node 'E' Nil Nil) (Node 'L' Nil Nil))

  print $ height numberBTree == 4
  print $ height charBTree == 3

  print $ average numberBTree == 16.22
  --print $ average charBTree -- should not work

  print $ sumLeaves numberBTree == 119
  --print $ sumLeaves charBTree -- shouldn't work

  print $ areEqual numberBTree (Node 5 (Node 12 (Node 1 (Node 96 Nil Nil) Nil) (Node 0 Nil Nil)) (Node 4 (Node 2 Nil Nil) (Node 5 Nil Nil))) == False
  print $ areEqual charBTree charBTree == True
  print $ areEqual numberBTree (Node 5 (Node 12 (Node 1 (Node 96 Nil Nil) Nil) (Node 0 Nil Nil)) (Node 8 (Node 2 Nil Nil) (Node 5 Nil (Node 21 Nil Nil)))) == False

  print $ setLevels numberBTree == Node (0,5) (Node (1,12) (Node (2,1) (Node (3,96) Nil Nil) Nil) (Node (2,0) Nil Nil)) (Node (1,4) (Node (2,2) Nil Nil) (Node (2,5) Nil (Node (3,21) Nil Nil)))
  print $ setLevels charBTree == Node (0,'k') (Node (1,'a') (Node (2,'h') Nil Nil) (Node (2,'s') Nil Nil)) (Node (1,'l') (Node (2,'e') Nil Nil) (Node (2,'l') Nil Nil))

  print $ mirrorTree numberBTree == Node 5 (Node 4 (Node 5 (Node 21 Nil Nil) Nil) (Node 2 Nil Nil)) (Node 12 (Node 0 Nil Nil) (Node 1 Nil (Node 96 Nil Nil)))
  print $ mirrorTree charBTree == Node 'k' (Node 'l' (Node 'l' Nil Nil) (Node 'e' Nil Nil)) (Node 'a' (Node 's' Nil Nil) (Node 'h' Nil Nil))

data BTree a = Nil | Node a (BTree a) (BTree a) 
  deriving (Show, Eq)

numberBTree :: BTree Int
numberBTree = Node 5 (Node 12 (Node 1 (Node 96 Nil Nil) Nil) (Node 0 Nil Nil)) (Node 4 (Node 2 Nil Nil) (Node 5 Nil (Node 21 Nil Nil)))

charBTree :: BTree Char
charBTree = Node 'k' (Node 'a' (Node 'h' Nil Nil) (Node 's' Nil Nil)) (Node 'l' (Node 'e' Nil Nil) (Node 'l' Nil Nil))

size :: BTree a -> Int
size Nil = 0
size (Node _ left right) = 1 + size left + size right

sumTree :: (Num a) => BTree a -> a
sumTree Nil = 0
sumTree (Node x left right) = x + sumTree left + sumTree right

traverseDFS :: BTree a -> [a]
traverseDFS Nil = []
traverseDFS (Node x left right) = traverseDFS left ++ [x] ++ traverseDFS right

getLevel :: BTree a -> Int -> [a]
getLevel Nil _ = []
getLevel (Node x _ _) 0 = [x]
getLevel (Node x left right) lvl = getLevel left (lvl - 1) ++ getLevel right (lvl - 1)

traverseBFS :: BTree a -> [a]
traverseBFS btree = concat $ takeWhile (not . null) $ map (getLevel btree) [0 .. ]

mapTree :: BTree a -> (a -> b) -> BTree b
mapTree Nil _ = Nil
mapTree (Node x left right) func = Node (func x) (mapTree left func) (mapTree right func)

height :: BTree a -> Int
height Nil = 0
height (Node _ left right) = 1 + max (height left) (height right)

roundTwoDig :: Double -> Double
roundTwoDig x = (/ 100) $ fromIntegral $ round $ x * 100

average :: Real a => BTree a -> Double
average tree = roundTwoDig $ realToFrac (sumTree tree) / fromIntegral (size tree)

sumLeaves :: (Num a) => BTree a -> a
sumLeaves Nil = 0
sumLeaves (Node n Nil Nil) = n
sumLeaves (Node _ left right) = sumLeaves left + sumLeaves right

areEqual :: (Eq a) => BTree a -> BTree a -> Bool
areEqual Nil Nil = True
areEqual Nil _ = False
areEqual _ Nil = False
areEqual (Node n1 left1 right1) (Node n2 left2 right2) = n1 == n2 && areEqual left1 left2 && areEqual right1 right2

-- areEqual :: (Eq a) => BTree a -> BTree a -> Bool
-- areEqual tr1 tr2 = tr1 == tr2

setLevels :: BTree a -> BTree (Int, a)
setLevels tr = helper tr 0
  where
    helper :: BTree a -> Int -> BTree (Int, a)
    helper Nil _ = Nil
    helper (Node x left right) currentLvl = Node (currentLvl, x) (helper left (currentLvl+1)) (helper right (currentLvl+1)) 

mirrorTree :: BTree a -> BTree a
mirrorTree Nil = Nil
mirrorTree (Node x left right) = Node x (mirrorTree right) (mirrorTree left)

