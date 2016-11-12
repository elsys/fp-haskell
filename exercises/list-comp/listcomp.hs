{-# OPTIONS_GHC -Wall #-}
module ListComp where

myLength :: [Int] -> Int
myLength list = sum [ 1 | _ <- list]

myElem :: Int -> [Int] -> Bool
myElem e list = not (null [x | x <- list, x == e])

myElem':: Int -> [Int] -> Bool
myElem' e l = and [True | x <- l, x == e]

myElem'':: Int -> [Int] -> Bool
myElem'' e l = or [ x == e | x <- l]

count :: Int -> [Int] -> Int
count e l = myLength [x | x <- l, x == e]


arithmeticSeries :: Int -> Int -> Int -> [Int]
arithmeticSeries a incrementator n = [a + x*incrementator | x <- [0..n-1]]

arithmeticSum :: Int -> Int -> Int -> Int
arithmeticSum a incrementator n = sum (arithmeticSeries a incrementator n)

geometricSeries :: Double -> Double -> Int -> [Double]
geometricSeries a q n = [a*q^x | x <- [0..n-1]]

geometricSum :: Double -> Double -> Int -> Double
geometricSum a q n = sum (geometricSeries a q n)

