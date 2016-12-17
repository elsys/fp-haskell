
module Plotter where

import Data.List(sort)


--plotter :: ( Int -> Int )-> String

makeReverseCoord :: (Int->Int)->[(Int,Int)]
makeReverseCoord f = [(f x, x) | x <- [1..20]]

findGreatestY :: [(Int, Int)] -> Int
findGreatestY xs = maximum [fst x | x <- xs]

removeNegative :: [(Int, Int)] -> [(Int, Int)]
removeNegative xs = [x | x <- xs, fst x >= 0]

generateLine :: Int -> String
generateLine x = replicate x ' ' ++ "*\n"

printGraph 0 _ = ""
printGraph l [] = concat (replicate l "\n")
printGraph l (x:xs)
   | l == fst x = generateLine (snd x) ++ printGraph (l - 1) xs
   | otherwise = "\n" ++ printGraph (l - 1) (x:xs)


plotter :: (Int -> Int) -> String
plotter f = let coord = makeReverseCoord f
                posCoord = removeNegative coord
                maxY = findGreatestY posCoord
            in printGraph maxY (reverse (sort posCoord))

