{-# OPTIONS_GHC -Wall #-}

module Lists where

import qualified Data.List ()

import Prelude hiding (
        head, tail, null, length, reverse, repeat, replicate,
        concat, sum, maximum, take, drop, elem, (!!)
    )


head :: [Int] -> Int
head []    = error "empty list"
head (x:_) = x


tail :: [Int] -> [Int]
tail []     = error "empty list"
tail (_:xs) = xs


append :: [Int] -> [Int] -> [Int]
append []     ys = ys
append (x:xs) ys = x : (append xs ys)


elementAt :: Int -> [Int] -> Int
elementAt 0 (x:_) = x
elementAt _ []     = error "index greater than length"
elementAt n (_:xs) = elementAt (n - 1) xs


null :: [Int] -> Bool
null [] = True
null _  = False

length :: [Int] -> Int
length = undefined


take :: Int -> [Int] -> [Int]
take _ [] = []
take 1 (x:xs) = [x]
take n _ | n < 1 = []
take n (x:xs) = x : take (n-1) xs

take' :: Int -> [Int] -> [Int]
take' 0 _  = []
take' n [] = [] 
take' n (x:xs) | n < 0     = []
               | otherwise = x : take' (n-1) xs


drop :: Int -> [Int] -> [Int]
drop = undefined


elem :: Int -> [Int] -> Bool
elem = undefined


reverseHelper :: [Int] -> [Int] -> [Int]
reverseHelper acc []     = acc
reverseHelper acc (x:xs) = reverseHelper (x:acc) xs

reverse :: [Int] -> [Int]
reverse xs = reverseHelper [] xs

reverseStringHelper::String->String->String
reverseStringHelper acc [] = acc
reverseStringHelper acc (x:xs) = (reverseStringHelper (x:acc) xs)


reverseString :: String -> String
reverseString str = "This is the reversed string: " ++ (reverseStringHelper [] str)

concat :: [[Int]] -> [Int]
concat = undefined


replicate :: Int -> Int -> [Int]
replicate = undefined


interleave :: [Int] -> [Int] -> [Int]
interleave = undefined


sum :: [Int] -> Int
sum = undefined


maximum :: [Int] -> Int
maximum = undefined


nub :: [Int] -> [Int]
nub = undefined


delete :: Int -> [Int] -> [Int]
delete = undefined


difference :: [Int] -> [Int] -> [Int]
difference = undefined


union :: [Int] -> [Int] -> [Int]
union = undefined


intersect :: [Int] -> [Int] -> [Int]
intersect = undefined
