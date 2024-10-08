import Data.List

main :: IO()
main = do
    print $ discount [("Pleven", 200, 5), ("Shumen", 259, 7), ("Varna", 20, 3)] 300 -- == [("Pleven",200,5.0),("Shumen",259,7.0),("Varna",20,3.0)]
    print $ discount [("Pleven", 200, 5), ("Shumen", 259, 7), ("Varna", 20, 3)] 250 -- == [("Pleven",200,5.0),("Shumen",259,6.3),("Varna",20,3.0)]
    print $ discount [("Pleven", 200, 5), ("Shumen", 259, 7), ("Varna", 20, 3)] 199 -- == [("Pleven",200,4.5),("Shumen",259,6.3),("Varna",20,3.0)]

    print $ shortenTour [("Pleven", 200, 5), ("Shumen", 259, 7), ("Varna", 20, 3)] "Pleven" "Sofia" ("Sofia", 3, 1) 
    print $ shortenTour [("Pleven", 200, 5), ("Shumen", 259, 7), ("Varna", 20, 3), ("Sofia", 200, 5)] "Pleven" "Sofia" ("Sofia", 3, 1) == [("Pleven",200,5.0),("Sofia",3,1.0)]
    print $ shortenTour [("Pleven", 200, 5), ("Shumen", 259, 7), ("Varna", 20, 3), ("Pleven", 200, 5), ("Shumen", 259, 7)] "Pleven" "Shumen" ("Burgas", 300, 14) == [("Pleven",200,5.0),("Burgas",300,14.0),("Varna",20,3.0),("Pleven",200,5.0),("Burgas",300,14.0)]

type Trip = (String, Integer, Float)
type Tour = [Trip]

discount :: Tour -> Integer -> Tour
discount tour len = foldr (\ t@(dest, ln, price) acc -> 
                              if ln > len 
                                then (dest, ln, price * 0.9) : acc 
                                else t : acc) [] tour


shortenTour :: Tour -> String -> String -> Trip -> Tour
shortenTour tour from to trip = helper tour False
 where
     helper :: Tour -> Bool -> Tour
     helper [] _ = []
     helper ((end, len, pr):ts) True
      | end == to = trip : helper ts False
      | otherwise = helper ts True
     helper ((end, len, pr):ts) False
      | end == from = (end, len, pr) : helper ts True
      | otherwise = (end, len, pr) : helper ts False
