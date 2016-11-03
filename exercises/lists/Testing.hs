{-# OPTIONS_GHC -Wall #-}

{-# LANGUAGE MagicHash #-}
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE ExistentialQuantification #-}

module Testing
    ( runTests
    , ap
    , ap2
    , before
    , throwsError
    , testEq
    , Test(..)
    ) where

import Data.Maybe
-- import Control.Arrow
import Control.Exception
import System.IO.Unsafe ( unsafePerformIO )
import GHC.Exts ( isTrue#, reallyUnsafePtrEquality# )


data Test    = forall a. Show a => Test String (a -> Bool) [a]
data Failure = forall a. Show a => Fail String [a]

instance Show Failure where
    show (Fail s as) = "Failed Test \"" ++ s
                       ++ "\" on inputs " ++ show as

ptrEq :: a -> a -> Bool
ptrEq x y = isTrue# (reallyUnsafePtrEquality# x y)

throwsError :: a
throwsError = error "throwsError"

isError :: a -> Bool
isError x = unsafePerformIO $
        handle (\(_ :: SomeException) -> return True) $ do
            let !_ = x
            return False

testEq :: Eq a => a -> a -> Bool
testEq res xpect = unsafePerformIO $
        handle (\(_ :: SomeException) -> return (xpect `ptrEq` throwsError && isError res)) $ do
            let !rtv = res == xpect
            return rtv

runTest :: Test -> Maybe Failure
runTest (Test s f as) = case filter (not . f) as of
                          [] -> Nothing
                          fs -> Just $ Fail s fs

printCase :: Show a => a -> String
printCase c = "    " ++ show c

printFail :: Failure -> String
printFail (Fail d cases) = "Failed: " ++ d ++ "\n" ++ unlines (map printCase cases)

runTests :: [Test] -> String
runTests tests = message
    where fails = catMaybes (map runTest tests)

          message | null fails = "Success!"
                  | otherwise  = unlines (map printFail fails)

before :: (a -> a -> Bool) -> (a -> a) -> a -> a -> Bool
before f g x y = f (g x) y

ap :: (r -> r -> Bool) -> (a -> r) -> (a, r) -> Bool
ap test f (a, b) = test (f a) b

ap2 :: (r -> r -> Bool) -> (a -> b -> r) -> (a, b, r) -> Bool
ap2 test f (a, b, c) = test (f a b) c
