
module Qsort where


qsort :: (a -> a -> Int) -> [a] -> [a]
qsort _ []     = []
qsort f (x:xs) = qsort f lesser ++ [x] ++ qsort f greater
    where lesser  = [ y | y <- xs, f y x <  0 ]
          greater = [ y | y <- xs, f y x >= 0 ]


asc :: Int -> Int -> Int
asc x y = x - y


desc :: Int -> Int -> Int
desc x y = y - x


test :: [Int]
test = [ 25, 40, 10, 100, 90, 20, 25 ]


sorted :: [Int]
sorted = qsort asc test

