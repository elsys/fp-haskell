{-# OPTIONS_GHC -Wall #-}

module Lists where

import qualified Data.List ()

import Prelude hiding (
        head, tail, null, length, reverse, repeat, replicate,
        concat, sum, maximum, take, drop, elem, (++), (!!)
    )


head :: [Int] -> Int
head = undefined


tail :: [Int] -> [Int]
tail = undefined


append :: [Int] -> [Int] -> [Int]
append = undefined


elementAt :: Int -> [Int] -> Int
elementAt = undefined


null :: [Int] -> Bool
null = undefined


length :: [Int] -> Int
length = undefined


take :: Int -> [Int] -> [Int]
take = undefined


drop :: Int -> [Int] -> [Int]
drop = undefined


elem :: Int -> [Int] -> Bool
elem = undefined


reverseHelper :: [Int] -> [Int] -> [Int]
reverseHelper = undefined

reverse :: [Int] -> [Int]
reverse = undefined


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
