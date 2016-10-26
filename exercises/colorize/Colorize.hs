{-# OPTIONS_GHC -Wall #-}

module Colorize where


backgroundStyle, textStyle :: Int
textStyle       = 30
backgroundStyle = 40


black, red, green, yellow, blue, magenta, cyan, white :: Int
black   = 0
red     = 1
green   = 2
yellow  = 3
blue    = 4
magenta = 5
cyan    = 6
white   = 7


clear :: Int
clear   = 0


-- Exercise 1

getLastDigit :: Int -> Int
getLastDigit = undefined


dropLastDigit :: Int -> Int
dropLastDigit = undefined


-- Exercise 2

getReverseDigits :: Int -> [Int]
getReverseDigits = undefined


-- Exercise 3

toChar :: Int -> Char
toChar = undefined


-- Exercise 4

itoaLoop :: String -> [Int] -> String
itoaLoop = undefined


itoa :: Int -> String
itoa = undefined


-- Exercise 5

mkStyle :: Int -> String
mkStyle style = "\x1B[" ++ itoa style ++ "m"


mkTextStyle :: Int -> String
mkTextStyle color = mkStyle (color + textStyle)


getStyle :: String -> String
getStyle = undefined


-- Exercise 6

removeStyle :: String -> String
removeStyle text = drop 1 (dropWhile (/= 'm') text)


bleach :: String -> String
bleach ('\x1B':rest) = bleach (removeStyle rest)
bleach (x:rest)      = x : bleach rest
bleach []            = []


colorize :: String -> String
colorize = undefined


-- Extra

mkBackgroundStyle :: Int -> String
mkBackgroundStyle = undefined


getMarkup :: String -> String
getMarkup = undefined


dropMarkup :: String -> String
dropMarkup = undefined


-- What bug does `colorize2` have? It's good that we know it, but we won't fix it now

colorize2 :: String -> String
colorize2 = undefined
