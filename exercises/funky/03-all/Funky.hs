
{-# OPTIONS_GHC -Wall #-}

module Funky where

import AST
import Parser (parseUnsafe)


emptyEnv :: Env
emptyEnv = []


unbox :: Maybe a -> String -> a
unbox (Just x) _   = x
unbox _        msg = error msg


runFunky :: String -> Value
runFunky src = runProgram emptyEnv (parseUnsafe src)


runProgram :: Env -> Program -> Value
runProgram env (Program decls) = evalExpr env' (Var "main")
    where env'     = env ++ map mkPair decls

          mkPair (FunctionDecl name params body) = (name, Function name params body)


evalMain :: Env -> Value -> Value
evalMain env (Function _ [] expr) = evalExpr env expr
evalMain _   _                    = error "Invalid `main` function definition"


evalExpr :: Env -> Expr -> Value
evalExpr _   (Constant c)     = IntValue c
evalExpr env (Arith op e1 e2) = evalArith op (evalExpr env e1) (evalExpr env e2)

evalExpr env (Var name) = normValue env val
    where val = unbox (lookup name env) ("Variable `" ++ name ++ "` not found!")

evalExpr env (Application eFunc eArgs) = evalExpr (bindArgs env params args) body
    where args = map (evalExpr env) eArgs
          func = evalExpr env eFunc

          -- TODO: error handling
          (Function _ params body) = func


normValue :: Env -> Value -> Value
normValue env (Function _ [] body) = evalExpr env body
normValue _   val                  = val


bindArgs :: Env -> [String] -> [Value] -> Env
bindArgs env params values
    | length params /= length values = error "Function applied to too few arguments"
    | otherwise                      = zip params values ++ env


unboxInt :: Value -> Int
unboxInt (IntValue i) = i
unboxInt _            = error "Not an integer"


evalArith :: ArithOp -> Value -> Value -> Value
evalArith op leftVal rightVal = IntValue (go op (unboxInt leftVal) (unboxInt rightVal))
    where go Add left right = left    +   right
          go Sub left right = left    -   right
          go Mul left right = left    *   right
          go Div left right = left `quot` right


showProgram :: Program -> String
showProgram (Program decls) = unlines (map showDeclaration decls)


showDeclaration :: Declaration -> String
showDeclaration (FunctionDecl name params body) = unwords [ name, paramsStr, "=", bodyStr, ";" ]
    where paramsStr = unwords params
          bodyStr   = showExpr body


showExpr :: Expr -> String
showExpr (Constant c) = show c
showExpr (Var s)      = s
showExpr (Application eFunc eArgs) = unwords (showExpr eFunc : map showExprAsAtom eArgs)
showExpr (Arith op left right)   = unwords [ showExprAsAtom left,
                                             showArithOp op,
                                             showExprAsAtom right ]


showArithOp :: ArithOp -> String
showArithOp Add = "+"
showArithOp Sub = "-"
showArithOp Mul = "*"
showArithOp Div = "/"


isAtom :: Expr -> Bool
isAtom (Constant _) = True
isAtom (Var _)      = True
isAtom _            = False


showExprAsAtom :: Expr -> String
showExprAsAtom expr | isAtom expr = showExpr expr
                    | otherwise   = "(" ++ showExpr expr ++ ")"


showValue :: Value -> String
showValue (IntValue i) = show i
showValue (Function name params _) = unwords (name:params)


test1, test2, test3, test4, test5 :: String
test1 = "main = 3 + 4;"
test2 = "f x y = x * y; main = f 4 5 + 11;"
test3 = "c = 9; main = c;"
test4 = "c = 42; f x = x - c; main = f 29 + c;"
test5 = "x = 20; f x = x - 9; main = f 10;"

