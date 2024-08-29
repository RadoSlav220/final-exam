import Data.List

main :: IO()
main = do
  print $ twig (T 1 [T 2 [], T 3 []]) == True
  print $ stick (T 1 [T 2 [T 3 [T 4 []]]]) == True
  print $ trim tree == T 1 [T 4 [], T 7 [T 9 []]]
  print $ prune tree == T 1 [T 2 [T 3 []], T 4 [T 5 []], T 7 [T 8 [], T 9 [T 10 []]]]

data Tree = T { root :: Int, subtrees :: [Tree] } deriving (Show, Eq)

tree = T 1 [T 2 [T 3 []], T 4 [T 5 [T 6 []]], T 7 [T 8 [], T 9 [T 10 [T 11 []]]]]

expl = T 1 [T 2 [T 3 []]]

leaf :: Tree -> Bool
leaf (T _ subtrees) = null subtrees

twig :: Tree -> Bool
twig (T _ subtrees) = all leaf subtrees

stick :: Tree -> Bool
stick (T _ []) = True
stick (T _ subtrees) = length subtrees == 1 && stick (head subtrees)

trim :: Tree -> Tree
trim (T x ts) = T x [trim sub | sub <- ts, not $ twig sub]

prune :: Tree -> Tree
prune t@(T x []) = t
prune t@(T x ts) = T x (if stick t
                        then [T (root $ head ts) []]
                        else map prune ts)
