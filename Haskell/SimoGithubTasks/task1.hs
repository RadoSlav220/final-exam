import System.IO

main :: IO()
main = do
  print $ min 5 6 == 5
  print $ minIf 15 60 == 15
  print $ minIf 60 15 == 15
  print $ minGuard 15 60 == 15
  print $ minGuard 60 15 == 15
  print $ minBuiltIn 60 15 == 15

  print $ lastDigit 154 == 4

  print $ quotientWhole 64 2 == 32
  print $ divWhole 154 17 == 9.058823529411764

  print $ removeLastDigit 154 == 15    

  print $ divReal 154.451 10.01 == 15.42967032967033
  print $ quotientReal 154.21 17.17 == 8

  print $ avgWhole 5 1542 == 773.5

  print $ roundTwoDig 3.1413465345321 == 3.14
  print $ roundTwoDigButWithMagic 3.1413465345321 == 3.14

  print $ inside 1 5 4 == True
  print $ inside 5 1 4 == True
  print $ inside 10 50 20 == True
  print $ inside 10 50 1 == False

  print $ inside2 1 5 4 == True
  print $ inside2 5 1 4 == True
  print $ inside2 10 50 20 == True
  print $ inside2 10 50 1 == False

minIf :: Int -> Int -> Int
minIf x y = if x > y then y else x

minGuard :: Int -> Int -> Int
minGuard x y 
  | x > y = y
  | otherwise = x

minBuiltIn :: Int -> Int -> Int
minBuiltIn = min

lastDigit :: Int -> Int
lastDigit = (`mod` 10)

quotientWhole :: Int -> Int -> Int
quotientWhole = div

divWhole :: Int -> Int -> Double
divWhole x y = fromIntegral x / fromIntegral y

removeLastDigit :: Int -> Int
removeLastDigit x = x `div` 10

divReal :: Double -> Double -> Double
divReal x y = x / y

quotientReal :: Double -> Double -> Int
quotientReal x y = floor $ divReal x y

avgWhole :: Int -> Int -> Double
avgWhole x y = fromIntegral (x + y) / 2

roundTwoDig :: Double -> Double
roundTwoDig x = (/ 100) $ fromIntegral $ round $ x * 100

roundTwoDigButWithMagic :: Double -> Double
roundTwoDigButWithMagic = (/100) . fromIntegral . round . (*100)

inside :: Int -> Int -> Int -> Bool
inside x y n = n >= min x y && n <= max x y

inside2 :: Int -> Int -> Int -> Bool
inside2 x y n = elem n [min x y .. max x y]
