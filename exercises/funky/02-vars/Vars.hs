
module Vars where

-- Adds varibales in addition to arithmetic
-- eg, we can now declare:
--    x = 5
--    y = x * 2
--    y + 1

data ArithOp = Add | Sub | Mul | Div
    deriving (Show)

data Expr = Constant Int
          | Var String
          | Arith ArithOp Expr Expr
          deriving (Show)

data VarDecl = VarDecl String Expr
    deriving (Show)

data Program = Program [VarDecl] Expr
    deriving (Show)

type Scope = [(String, Int)]


evalExpr :: Scope -> Expr -> Int
evalExpr _   (Constant x) = x

evalExpr scope (Var name) = unbox (find name scope)
    where unbox (Just val) = val
          unbox Nothing    = error ("Varible `" ++ name ++ "` not found!")

evalExpr scope (Arith op left right) = doArith op leftVal rightVal
    where leftVal  = evalExpr scope left
          rightVal = evalExpr scope right


-- prelude provides such a function called `lookup`
find :: Eq a => a -> [(a, b)] -> Maybe b
find _ []                        = Nothing
find x ((y, val):ys) | x == y    = Just val
                     | otherwise = find x ys


doArith :: ArithOp -> Int -> Int -> Int
doArith Add left right = left + right
doArith Sub left right = left - right
doArith Mul left right = left * right
doArith Div left right = left `quot` right


eval :: Program -> Int
eval (Program decls body) = evalExpr (mkScope [] decls) body
    where mkScope sc []                       = sc
          mkScope sc (VarDecl name expr : xs) = mkScope ((name, evalExpr sc expr):sc) xs


test :: Program
test = Program [] (Arith Add (Constant 3) (Constant 4))


test2 :: Program
test2 = Program [ VarDecl "x" (Constant 42) ] (Var "x")


test3 :: Program
test3 = Program [ VarDecl "x" (Constant 5),
                  VarDecl "y" (Arith Mul (Var "x") (Constant 2)) ]

                (Arith Add (Var "y") (Constant 1))

