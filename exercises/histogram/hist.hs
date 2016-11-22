module Histogram where

baseString::String
baseString = ['0'..'9']

count :: (Eq a) => a -> [a] -> Int
count item list = length [x | x <- list, x == item]

frequency :: [Int] -> [Int]
frequency list = [count x list | x <- [0..9]]

decrement :: [Int] -> [Int]
decrement list = [x - 1 | x <- list]

hasPositive :: [Int] -> Bool
hasPositive list = not (null [x | x <- list, x > 0])

makeLine :: [Int] -> String
makeLine list = [if x > 0 then '*' else ' ' | x <- list]

freq2hist :: [Int] -> [String]
freq2hist x
    | hasPositive x = makeLine x : freq2hist (decrement x)
    | otherwise     = []

histogram :: [Int] -> String
histogram x = unlines (reverse histLines ++ [baseString])
    where histLines = freq2hist (frequency x)
