
module Arith where

-- Simple calculator - supports the basic arith operations (+, -, *, /)
-- and arbitrary combinations of them

data Expr = Constant Int
          | Add Expr Expr
          | Sub Expr Expr
          | Mul Expr Expr
          | Div Expr Expr
          deriving (Show)


eval :: Expr -> Int
eval (Constant x)     = x
eval (Add left right) = eval left + eval right
eval (Sub left right) = eval left - eval right
eval (Mul left right) = eval left * eval right
eval (Div left right) = eval left `quot` eval right


-- in class: what is the human form?
test :: Expr
test =  Add (Mul (Constant 3) (Constant 4)) (Sub (Constant 10) (Constant 7))


-- in class: write (10 / 2) + 5
test2 :: Expr
test2 = Add (Div (Constant 10) (Constant 2)) (Constant 5)


-- in class: discuss why Add/Sub/.. constructors are not convenient.
-- e.g. how can we write a proper show?

