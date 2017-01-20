
{-# LANGUAGE NoMonomorphismRestriction #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE TypeFamilies #-}

import Diagrams.Prelude
import Diagrams.Backend.SVG.CmdLine
import Diagrams.Backend.SVG
import Diagrams.TwoD.Input
import Diagrams.SVG.ReadSVG

img :: Either String (Diagram SVG) -> Diagram B
img (Left e)  = error e
img (Right i) = i

fixFish :: Diagram B -> Diagram B
fixFish img = alignX off . alignY 0 $ img
              where t = abs $ width img - height img
                    off = t / width img

rot :: Diagram B -> Diagram B
rot x = rotate (90 @@ deg) x

rot45 :: Diagram B -> Diagram B
rot45 x = fixRot . scale (1/sqrt 2). rotate (-45 @@ deg) . reflectX $ x
          where
            fixRot img = alignX 0 . alignY (-0.978) $ img

blank :: Diagram B -> Diagram B
blank i = opacity 0 i

fish2 :: Diagram B -> Diagram B
fish2 i = rot45 i

fish3 :: Diagram B -> Diagram B
fish3 i = rot . rot . rot . fish2 $ i

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
side1 i = let b = blank i
              t = fishT i
          in quartet b b (rot t) t b

side :: Int -> Diagram B -> Diagram B
side 1 i = side1 i
side x i = let s = scale 0.5 . fixY $ side (x-1) i
               t = fishT i
           in  quartet s s (rot t) t b
           where
             b = blank i
             fixY = translateY (-(width b - height b)/2)

tile :: Int -> Diagram B -> Diagram B
tile = undefined

main = do
 x <- loadImageEmbedded "fish.svg"
 let fish  = fixFish . img $ x
 mainWith $ fish

