{-# LANGUAGE NoMonomorphismRestriction #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE TypeFamilies #-}

import Diagrams.Prelude
import Diagrams.Backend.SVG.CmdLine
import Diagrams.Backend.SVG
import Diagrams.TwoD.Input
import Diagrams.SVG.ReadSVG

img :: Either String (Diagram SVG) -> Diagram B
img = undefined

fixFish :: Diagram B -> Diagram B
fixFish = undefined

rot :: Diagram B -> Diagram B
rot = undefined

rot45 :: Diagram B -> Diagram B
rot45 = undefined

blank :: Diagram B -> Diagram B
blank = undefined

fish2 :: Diagram B -> Diagram B
fish2 = undefined

fish3 :: Diagram B -> Diagram B
fish3 = undefined

fishT :: Diagram B -> Diagram B
fishT = undefined

fishU :: Diagram B -> Diagram B
fishU = undefined

quartet p q r s b = centerXY $ p `atop` fixX q `atop` fixY (r `atop` fixX s)
                  where
                    off = min (width b) (height b)
                    fixX = translateX off
                    fixY = translateY (-off)

side1 :: Diagram B -> Diagram B
side1 = undefined

side :: Int -> Diagram B -> Diagram B
side = undefined

tile :: Int -> Diagram B -> Diagram B
tile = undefined

main = do
 x <- loadImageEmbedded "fish.svg"
 let fish  = fixFish . img $ x
 mainWith $ fish

