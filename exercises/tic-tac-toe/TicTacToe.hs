
{-# LANGUAGE MultiWayIf #-}

module TicTacToe where

data Tile = X | O | Empty
    deriving (Eq)

data Board = Board [Tile]

data GameState = GameState Tile Board


emptyBoard :: Board
emptyBoard = Board (replicate 9 Empty)


emptyState :: GameState
emptyState = GameState X emptyBoard


printTile :: Tile -> String
printTile X     = "X"
printTile O     = "O"
printTile Empty = " "


group :: Int -> [a] -> [[a]]
group n _  | n <= 0 = error "non-positive n"

group _ [] = []
group n xs = take n xs : group n (drop n xs)


printBoard :: Board -> String
printBoard (Board tiles) = unlines . map mkLine . group 3 $ map printTile tiles
    where mkLine [x, y, z] = x ++ " | " ++ y ++ " | " ++ z


isValidMove :: Int -> Board -> Bool
isValidMove n (Board tiles)
    | n < 0 || n >= 9     = False
    | otherwise           = tiles !! n == Empty


move :: Int -> Tile -> Board -> Board
move n player board@(Board tiles)
    | not (isValidMove n board) = error "Invalid move"
    | player == Empty           = error "Invalid player"
    | otherwise                 = Board (take n tiles ++ [player] ++ drop (n + 1) tiles)


isBoardFull :: Board -> Bool
isBoardFull (Board tiles) = all (/= Empty) tiles


flipPlayer :: Tile -> Tile
flipPlayer X     = O
flipPlayer O     = X
flipPlayer Empty = Empty


isWinFor :: Tile -> Board -> Bool
isWinFor X (Board tiles) =    isRowWinForX  tiles
                           || isColWinForX  tiles
                           || isDiagWinForX tiles

isWinFor O (Board tiles) = isWinFor X (Board $ map flipPlayer tiles)


isRowWinForX :: [Tile] -> Bool
isRowWinForX [ X, X, X, _, _, _, _, _, _ ] = True
isRowWinForX [ _, _, _, X, X, X, _, _, _ ] = True
isRowWinForX [ _, _, _, _, _, _, X, X, X ] = True
isRowWinForX _                             = False


isColWinForX :: [Tile] -> Bool
isColWinForX [ X, _, _, X, _, _, X, _, _ ] = True
isColWinForX [ _, X, _, _, X, _, _, X, _ ] = True
isColWinForX [ _, _, X, _, _, X, _, _, X ] = True
isColWinForX _                             = False


isDiagWinForX :: [Tile] -> Bool
isDiagWinForX [ X, _, _,
                _, X, _,
                _, _, X ] = True

isDiagWinForX [ _, _, X,
                _, X, _,
                X, _, _ ] = True

isDiagWinForX   _         = False


isDigitsOnly :: String -> Bool
isDigitsOnly str = all (\c -> c `elem` ['0'..'9']) str


getStep :: GameState -> IO Int
getStep state@(GameState player board)
    = do putStr $ "Player " ++ printTile player ++ "> "
         input <- getLine

         let num = (read input :: Int) - 1

         if | not (isDigitsOnly input)
                -> do putStrLn "Invalid step, digit 1~9 expected"
                      getStep state

            | not (isValidMove num board)
                -> do putStrLn "Invalid move, already taken"
                      getStep state

            | otherwise
                -> return num


gameLoop :: GameState -> IO ()
gameLoop state@(GameState player board)
    = do putStrLn $ printBoard board

         if | isWinFor X board  -> putStrLn "X wins!"
            | isWinFor O board  -> putStrLn "O wins!"
            | isBoardFull board -> putStrLn "It's a tie!"

            | otherwise         -> do step <- getStep state
                                      gameLoop $ GameState (flipPlayer player) (move step player board)


main = gameLoop emptyState

