import Data.List

main :: IO()
main = do
  print $ calc lib (head exprs) 3 == 8
  print $ score (-10) 10 lib [(\x -> x^2-1), (\x -> x*3+2), (\x -> x^3+2*x^2), (\x -> x^3+1)] exprs == 0.5


data Expr = N Integer | X | F Char Expr Expr

exprs = [F '-' (F '*' X X) (N 1), F '+' (F '*' X (N 2)) (N 3), F '*' (F '*' X X) (F '+' X (N 2)), F '+' (F '^' X (N 3)) (N 1)]
lib = [('+',(+)),('-',(-)),('*',(*))]

correct :: [(Char, Integer -> Integer -> Integer)] -> Expr -> Bool
correct lib (F f l r) = elem f (map fst lib) && correct lib l && correct lib r
correct lib _ = True

calc :: [(Char, Integer -> Integer -> Integer)] -> Expr -> Integer -> Integer
calc lib (N n) = (\ _ -> n)
calc lib X = (\x -> x)
calc lib (F c l r) = (\x -> func (calc lib l x) (calc lib r x)) 
  where func = head [f | (ch, f) <- lib, c == ch]

check :: Integer -> Integer -> [(Char, Integer -> Integer -> Integer)] -> (Integer -> Integer) -> Expr -> Bool
check a b lib f expr = all (\x -> correct lib expr && calc lib expr x == f x) [a ..b]

score :: Fractional a => Integer -> Integer -> [(Char, Integer -> Integer -> Integer)] -> [Integer -> Integer] -> [Expr] -> a
score a b lib fs exprs = fromIntegral (length (filter (\(f, e) -> check a b lib f e) (zip fs exprs))) / fromIntegral (length exprs)