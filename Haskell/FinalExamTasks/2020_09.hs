import Data.List

main::IO()
main = do
  print $ rf ("Mozart","The Marriage of Figaro Overture",270) == ("Gershwin","Summertime",300)
  print $ rf ("Gershwin", "Summertime", 300) == ("Gershwin","Rhapsody in Blue",1100)
  print $ rf ("Gershwin", "Rhapsody in Blue", 1100) == ("Queen","Bohemian Rhapsody",355)

rf = recommender [("Mozart","The Marriage of Figaro Overture",270), 
                  ("Gershwin","Summertime",300), 
                  ("Queen","Bohemian Rhapsody",355), 
                  ("Gershwin","Rhapsody in Blue",1100)]

recommender pl = (\(a, n, d) ->
  let avgDuration artist = let pieces = [ dur | (auth, _, dur) <- pl, auth == artist] in fromIntegral (sum pieces) / fromIntegral (length pieces)
      option1 = filter (\(pAuth, _, pDur) -> pAuth == a && pDur > d) pl
      option2 = filter (\(pAuth, _, _) -> avgDuration pAuth < avgDuration a) pl
  in if not (null option1) then (head option1)
     else if not (null option2) then last option2
     else head $ (filter (\(_, _, dur) -> dur > d) pl) ++ [(a, n, d)])