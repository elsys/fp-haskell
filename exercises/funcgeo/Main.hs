
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

getBox :: Diagram B -> Diagram B
getBox img = square $ min (width img) (height img)

fixFish :: Diagram B -> Diagram B
fixFish img = let alignedImg = alignBR img
                  alignedBox = getEnvelope $ alignBR $ getBox img
              in
                  centerXY . setEnvelope alignedBox $ alignedImg

rot :: Diagram B -> Diagram B
rot x = rotate (90 @@ deg) x

rot45 :: Diagram B -> Diagram B
rot45 x = fixRot . scale (1/sqrt 2). rotate (-45 @@ deg) . reflectX $ x
          where
            fixRot img = setEnvelope (getEnvelope $ getBox x) $ alignB img

blank :: Diagram B -> Diagram B
blank i = opacity 0 i

fish2 :: Diagram B -> Diagram B
fish2 i = rot45 i

fish3 :: Diagram B -> Diagram B
fish3 i = rot . rot . rot . fish2 $ i


fishT :: Diagram B -> Diagram B
fishT i = i `atop` (fish2 i `atop` fish3 i)

fishU :: Diagram B -> Diagram B
fishU i = rotFN 0 `atop` rotFN 1 `atop` (rotFN 2 `atop` rotFN 3)
        where
          rotFN 0 = fish2 i
          rotFN n = rot $ rotFN (n-1)


quartet p q r s = centerXY $ (p ||| q)
                                ===
                             (r ||| s)

nonet p q r s t u x y z = centerXY $ ( p ||| q ||| r )
                                            ===
                                     ( s ||| t ||| u )
                                            ===
                                     ( x ||| y ||| z )

side1 :: Diagram B -> Diagram B
side1 i = let b = blank i
              t = fishT i
          in quartet b b (rot t) t

side :: Int -> Diagram B -> Diagram B
side 1 i = side1 i
side n i = let s = scale 0.5 $ side (n-1) i
               t = fishT i
           in  quartet s s (rot t) t

corner1 :: Diagram B -> Diagram B
corner1 i = let b = blank i
                u = fishU i
            in quartet b b b u

corner :: Int -> Diagram B -> Diagram B
corner 1 i = corner1 i
corner n i = let c = scale 0.5 $ corner (n - 1) i
                 s = scale 0.5 $ side (n - 1) i
                 u = fishU i
             in quartet c s (rot s) u

squareLimit :: Int -> Diagram B -> Diagram B
squareLimit n i = let tl = corner n i
                      tc = side n i
                      tr = rot . rot . rot $ corner n  i
                      ml = rot $ side n i
                      mc = scale 2 $ fishU i
                      mr = rot . rot . rot $ side n i
                      bl = rot $ corner n i
                      bc = rot . rot $ side n i
                      br = rot . rot $ corner n i
                  in  nonet tl tc tr ml mc mr bl bc br

main = do
 x <- loadImageEmbedded "fish.svg"
 let fish  = fixFish . img $ x
 mainWith $ squareLimit 4 fish

