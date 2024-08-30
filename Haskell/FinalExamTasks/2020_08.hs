import Data.List

main::IO()
main = do
  print "hello"
  print $ maxSlope (head tracks) == 0.2
  print $ easiestTrackUnder 800 tracks == [(0, 900), (100, 910), (200, 925), (300, 905), (600, 950)]

tracks = [[(0, 900), (100, 910), (200, 925), (300, 905), (600, 950)],
          [(0, 1300), (100, 1305), (500, 1340), (800, 1360), (1000, 1320)],
          [(0, 800), (200, 830), (300, 845), (600, 880), (800, 830)]]

argMin f l = head [x | x <- l, f x == minimum (map f l)]

-- argMin f l = foldl1 (\ x y -> if f x < f y then x else y) l

maxSlope track = maximum (map (\((l1, h1), (l2, h2)) -> abs (h1 - h2) / abs (l1 - l2)) (zip track (tail track)))

easiestTrackUnder maxLen tracks = 
  argMin maxSlope (filter (\tr -> fst (last tr) < maxLen) tracks)
