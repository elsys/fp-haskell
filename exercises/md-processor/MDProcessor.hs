
module MDProcessor where

data Lang = Haskell | C | Python | None deriving (Eq, Show)
data HeadingSize = H1 | H2 | H3 | H4 deriving (Eq, Show)
data ListMode = Ordered | Unordered deriving (Eq, Show)

data Element =
        Text String
      | Bold Element
      | Italic Element
      | Underline Element
      | Heading HeadingSize String
      | CodeBlock Lang [String]
      | List ListMode [Element]
      | HorizontalRule
      deriving (Eq, Show)

myText :: Element
myText = Italic (Bold (Underline (Text "This is a test")))


headingPrefix :: HeadingSize -> String
headingPrefix H1 = "#"
headingPrefix H2 = "##"
headingPrefix H3 = "###"
headingPrefix H4 = "####"

lang :: Lang -> String
lang Haskell = "hs"
lang C = "c"
lang Python = "py"
lang None = ""

render2md :: Element -> String
render2md (Text s) = s
render2md (Bold el) = "**" ++ render2md el ++ "**"
render2md (Italic el) = "_" ++ render2md el ++ "_"
render2md (Underline el) = "__" ++ render2md el ++ "__"
render2md (Heading size str) = headingPrefix size ++ str
render2md (CodeBlock pl code) = "```" ++ lang pl ++ "\n" ++ unlines code ++ "```"
render2md HorizontalRule = "---"
render2md (List mode items) = renderList mode items
  where
    --renderList :: ListMode -> [Element] -> String
    renderList Ordered l = unlines [show i ++ ". " ++ render2md (l !! (i-1)) | i <- [1..length l]]
    renderList Unordered l = unlines ["- " ++ render2md x | x <- l]

