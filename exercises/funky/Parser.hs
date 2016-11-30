-- default: provided

{-# OPTIONS_GHC -Wall #-}

module Parser where

import AST

import qualified Text.Parsec as P

import Text.Parsec ((<?>), optional, option, try)
import Text.Parsec.String (Parser)
import Text.Parsec.Char (oneOf, char, digit, letter)
import Text.Parsec.Combinator (many1)

import Control.Applicative ((<|>), many)

import Data.Either.Combinators (mapLeft)


parse src = mapLeft show $ P.parse parseProgram "" src


parseUnsafe :: String -> Program
parseUnsafe = go . parse
    where go (Left err)  = error $ unlines ["Parsing filed:", err]
          go (Right res) = res


parseProgram :: Parser Program
parseProgram = do skipWs
                  decls <- many1 (parseDeclaration <* skipWs)

                  return $ Program decls


parseDeclaration :: Parser Declaration
parseDeclaration = parseFunctionDecl


parseFunctionDecl :: Parser Declaration
parseFunctionDecl = do name <- parseId
                       skipWs

                       args <- many (parseId <* skipWs)

                       char '=' *> skipWs

                       body <- parseExpr

                       skipWs <* char ';' <?> "did you forget `;` ?"

                       return $ FunctionDecl name args body


parseExpr :: Parser Expr
parseExpr = parseArith


parseAtom :: Parser Expr
parseAtom =     parseConstant
            <|> parseVar
            <|> do char '(' *> skipWs

                   expr <- parseExpr

                   skipWs <* char ')'
                   return expr


parseApplication :: Parser Expr
parseApplication = do f    <- parseAtom

                      option f $ do args <- many1 (try $ parseWs *> parseAtom)
                                    return $ Application f args


parseArithOp :: Parser ArithOp
parseArithOp =     char '+' *> pure Add
               <|> char '-' *> pure Sub
               <|> char '*' *> pure Mul
               <|> char '/' *> pure Div


parseArith :: Parser Expr
parseArith = do left <- parseApplication

                skipWs
                option left $ do op <- parseArithOp
                                 skipWs

                                 right <- parseArith

                                 return $ Arith op left right


parseVar :: Parser Expr
parseVar = Var <$> parseId


parseConstant :: Parser Expr
parseConstant = parseNumber


parseNumber :: Parser Expr
parseNumber = Constant . read <$> many1 digit


parseWs :: Parser String
parseWs = many1 (oneOf " \n\t")


skipWs = optional parseWs


parseId = do firstChar <- letter <|> char '_'
             rest      <- many (letter <|> char '_' <|> digit)

             return (firstChar:rest)

