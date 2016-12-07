
module AST where

data ArithOp = Add | Sub | Mul | Div
    deriving (Show)

data Value = IntValue Int
           | Function String [String] Expr
           deriving (Show)

data Expr = Constant Int
          | Arith ArithOp Expr Expr
          | Var String
          | Application Expr [Expr]
          deriving (Show)

data Declaration = FunctionDecl String [String] Expr
    deriving (Show)

data Program = Program [Declaration]
    deriving (Show)

type Env = [(String, Value)]

