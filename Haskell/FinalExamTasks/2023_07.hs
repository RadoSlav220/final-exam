import Data.List

main :: IO()
main = do
  print $ selectCouncil 2 [b1, b2, b3] cl == ["Ritchie","Kernighan"]
  print $ votes ("Ritchie","C") [b1, b2, b3] == 3
  print $ votes ("RitchieL","C") [b1, b2, b3] == 2
  print $ election [b1, b2, b3] cl == [("Kernighan",2),("Ritchie",3),("Stroustrup",1),("Steele",1),("Sussman",1),("Church",2),("Curry",1)]
  print $ (sortResults $ election [b1, b2, b3] cl) == [("Ritchie",3),("Kernighan",2),("Church",2),("Stroustrup",1),("Steele",1),("Sussman",1),("Curry",1)]

votes :: (String, String) -> [(String, String) -> Bool] -> Int
votes cand ballots = length $ filter (\b -> b cand) ballots

election :: [(String, String) -> Bool] -> [(String, String)] -> [(String, Int)]
election ballots cl = map (\c@(name, spec) -> (name, votes c ballots)) cl

sortResults :: [(String, Int)] -> [(String, Int)]
sortResults [] = []
sortResults ((name, result) : xs) = more ++ equal ++ less
  where more = sortResults $ filter (\(_, res) -> res > result) xs
        equal = (name, result) : filter (\(_, res) -> res == result) xs
        less = sortResults $ filter (\(_, res) -> res < result) xs

selectCouncil :: Int -> [(String, String) -> Bool] -> [(String, String)] -> [String]
selectCouncil max ballots cl = take max (map fst (filter (\(_, res) -> res > length ballots `div` 2) results))
  where results = sortResults (election ballots cl)

cl = [("Kernighan","C"),("Ritchie","C"),("Stroustrup","C++"),("Steele","Scheme"), ("Sussman","Scheme"),("Church","Lambda"),("Curry","Lambda")]
b1 (name, specialty) = specialty == "Lambda" || last name == 'e'
b2 (name, specialty) = name == "Church" || head specialty == 'C'
b3 (name, specialty) = length name > 6 && specialty /= "C++"