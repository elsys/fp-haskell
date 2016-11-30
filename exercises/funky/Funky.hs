{-# OPTIONS_GHC -Wall #-}

module Funky where

import AST
import Parser (parseUnsafe)


emptyEnv :: Env
emptyEnv = undefined


unbox :: Maybe a -> String -> a
unbox = undefined


runFunky :: String -> Value
runFunky = undefined


runProgram :: Env -> Program -> Value
runProgram = undefined


evalMain :: Env -> Value -> Value
evalMain = undefined


evalExpr :: Env -> Expr -> Value
evalExpr = undefined


normValue :: Env -> Value -> Value
normValue = undefined


bindArgs :: Env -> [String] -> [Value] -> Env
bindArgs = undefined


unboxInt :: Value -> Int
unboxInt = undefined


evalArith :: ArithOp -> Value -> Value -> Value
evalArith = undefined


showProgram :: Program -> String
showProgram = undefined


showDeclaration :: Declaration -> String
showDeclaration = undefined


showExpr :: Expr -> String
showExpr = undefined


showArithOp :: ArithOp -> String
showArithOp = undefined


isAtom :: Expr -> Bool
isAtom = undefined


showExprAsAtom :: Expr -> String
showExprAsAtom = undefined


showValue :: Value -> String
showValue = undefined


test1, test2, test3, test4 :: String
test1 = "main = 3 + 4;"
test2 = "f x y = x * y; main = f 4 5 + 11;"
test3 = "c = 9; main = c;"
test4 = "c = 42; f x = x - c; main = f 29 + c;"

