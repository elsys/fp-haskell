{-# OPTIONS_GHC -Wall #-}

module ListTests where

import Testing
import Lists as L
import Data.List as DL


headTest :: Test
headTest = Test "head" (ap testEq L.head) [
        ([1, 2, 3],  1),
        ([10],       10),
        ([],         throwsError)
    ]

tailTest :: Test
tailTest = Test "tail" (ap testEq L.tail) [
        ([1, 2, 3],  [2, 3]),
        ([10],       []),
        ([],         throwsError)
    ]

appendTest :: Test
appendTest = Test "append" (ap2 testEq L.append) [
        ([1, 2, 3], [4, 5, 6], [1, 2, 3, 4, 5, 6]),
        ([1, 2, 3], [],        [1, 2, 3]),
        ([],        [1, 2, 3], [1, 2, 3]),
        ([],        [],        [])
    ]

elementAtTest :: Test
elementAtTest = Test "elementAt" (ap2 testEq L.elementAt) [
        (0,  [1, 2, 3], 1),
        (1,  [1, 2, 3], 2),
        (2,  [1, 2, 3], 3),
        (4,  [1, 2, 3], throwsError),
        (-1, [1, 2, 3], throwsError)
    ]

nullTest :: Test
nullTest = Test "null" (ap testEq L.null) [
        ([],      True),
        ([0],     False),
        ([1,2,3], False)
    ]

lengthTest :: Test
lengthTest = Test "length" (ap testEq L.length) [
        ([],      0),
        ([0],     1),
        ([1,2,3], 3)
    ]

reverseTest :: Test
reverseTest = Test "reverse" (ap testEq L.reverse) [
        ([],      []),
        ([0],     [0]),
        ([1,2,3], [3, 2, 1])
    ]

replicateTest :: Test
replicateTest = Test "replicate" (ap2 testEq L.replicate) [
        (-1, 1, []),
        (0,  1, []),
        (1,  1, [1]),
        (5,  2, [2, 2, 2, 2, 2])
    ]

interleaveTest :: Test
interleaveTest = Test "interleave" (ap2 testEq L.interleave) [
        ([],           [1, 2, 3],    []),
        ([1, 2, 3],    [],           [1]),
        ([1, 2, 3],    [4, 5, 6, 7], [1, 4, 2, 5, 3, 6]),
        ([1, 2, 3, 4], [5, 6, 7], [1, 5, 2, 6, 3, 7, 4])
    ]

concatTest :: Test
concatTest = Test "concat" (ap testEq L.concat) [
        ([],                []),
        ([[1, 2]],          [1, 2]),
        ([[1, 2], [3, 4]],  [1, 2, 3, 4]),
        ([[1, 2], [3], []], [1, 2, 3])
    ]

sumTest :: Test
sumTest = Test "sum" (ap testEq L.sum) [
        ([],              0),
        ([1, 2],          3),
        ([1, 2, 4, -10], -3),
        ([-20],          -20)
    ]

maximumTest :: Test
maximumTest = Test "maximum" (ap testEq L.maximum) [
        ([],              throwsError),
        ([1, 2],          2),
        ([1, 2, 4, -10],  4),
        ([-20, -10, -5], -5)
    ]

takeTest :: Test
takeTest = Test "take" (ap2 testEq L.take) [
        ( 10, [],           []),
        (-10, [1, 2],       []),
        (  2, [1, 2, 3, 4], [1, 2]),
        (  0, [1, 2, 3, 4], []),
        ( 10, [1, 2, 3, 4], [1, 2, 3, 4])
    ]

dropTest :: Test
dropTest = Test "drop" (ap2 testEq L.drop) [
        (10,  [],           []),
        (-10, [1, 2],       [1, 2]),
        ( 2,  [1, 2, 3, 4], [3, 4]),
        ( 0,  [1, 2, 3, 4], [1, 2, 3, 4]),
        (10,  [1, 2, 3, 4], [])
    ]

elemTest :: Test
elemTest = Test "elem" (ap2 testEq L.elem) [
        (10,  [],           False),
        ( 1,  [1, 2],       True),
        ( 4,  [1, 2, 3, 4], True),
        ( 5,  [1, 2, 3, 4], False)
    ]

nubTest :: Test
nubTest = Test "nub" (ap (before testEq DL.sort) L.nub) [
        ([],                    []),
        ([1, 2, 3],             [1, 2, 3]),
        ([1, 2, 2, 1, 3, 5, 5], [1, 2, 3, 5])
    ]

deleteTest :: Test
deleteTest = Test "delete" (ap2 testEq L.delete) [
        (10,  [],            []),
        ( 1,  [1, 2, 3],     [2, 3]),
        ( 2,  [1, 2, 2, 3],  [1, 2, 3]),
        ( 5,  [1, 2, 2, 3],  [1, 2, 2, 3])
    ]

differenceTest :: Test
differenceTest = Test "difference" (ap2 (before testEq DL.sort) L.difference) [
        ([],              [],        []),
        ([1, 2, 3],       [],        [1, 2, 3]),
        ([],              [1, 2, 3], []),
        ([1, 2, 3],       [4, 5, 6], [1, 2, 3]),
        ([1, 2, 3],       [1, 2, 3], []),
        ([1, 2, 2, 3, 3], [1, 3, 4], [2, 2, 3]),
        ([1, 2, 2, 3, 3], [1, 3, 3], [2, 2])
    ]

unionTest :: Test
unionTest = Test "union" (ap2 (before testEq DL.sort) L.union) [
        ([],              [],        []),
        ([1, 2, 3],       [],        [1, 2, 3]),
        ([],              [1, 2, 3], [1, 2, 3]),
        ([1, 2, 3],       [4, 5, 6], [1, 2, 3, 4, 5, 6]),
        ([1, 2, 3],       [1, 2, 3], [1, 2, 3]),
        ([1, 2, 2, 3, 3], [1, 3, 3], [1, 2, 2, 3, 3]),
        ([1, 2, 2, 3, 3], [1, 3, 4], [1, 2, 2, 3, 3, 4])
    ]

intersectTest :: Test
intersectTest = Test "intersect" (ap2 (before testEq DL.sort) L.intersect) [
        ([],              [],        []),
        ([1, 2, 3],       [],        []),
        ([],              [1, 2, 3], []),
        ([1, 2, 3],       [4, 5, 6], []),
        ([1, 2, 3],       [1, 2, 3], [1, 2, 3]),
        ([1, 2, 2, 3, 3], [1, 3, 3], [1, 3, 3]),
        ([1, 2, 2, 3, 3], [1, 3, 4], [1, 3, 3])
    ]

allTests :: [Test]
allTests = [ headTest
           , tailTest
           , appendTest
           , elementAtTest
           , nullTest
           , lengthTest
           , reverseTest
           , replicateTest
           , interleaveTest
           , concatTest
           , sumTest
           , maximumTest
           , takeTest
           , dropTest
           , elemTest
           , nubTest
           , deleteTest
           , differenceTest
           , unionTest
           , intersectTest
           ]
