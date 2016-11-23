module MDParser where

data Lang = HS | C | None
data HeadingSize = Small | Meduim | Big | Huge
data ListMode = Ordered | Unordered

data Element =
        Text String
      | Bold Element
      | Italic Element
      | Heading HeadingSize String
      | CodeBlock Lang [String]
      | List ListMode [Element]
      | Rule

