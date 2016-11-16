import Test.Hspec

import MdTable

main :: IO ()
main = hspec $ do
  describe "padWith" $ do
    it "pads an array with the provided element" $ do
      padWith 42 5 [1, 2, 3] `shouldBe` [1, 2, 3, 42, 42]
      padWith 42 5 []        `shouldBe` [42, 42, 42, 42, 42]

    it "returns the array intact if padding is not applicable" $ do
      padWith 42 0 [1, 2, 3] `shouldBe` [1, 2, 3 ]
      padWith 42 2 [1, 2, 3] `shouldBe` [1, 2, 3 ]

  describe "layoutTable" $ do
    it "layouts a table" $ do
      layoutTable [
                    ["Item", "Price", "Available"]
                  ]
        `shouldBe` "| Item      | Price     | Available |\n| --------- | --------- | --------- |\n"

      layoutTable [
                    ["Col 1",    "Col 2" ],
                    ["Not much", "to say"]
                  ]
        `shouldBe` "| Col 1    | Col 2    |\n| -------- | -------- |\n| Not much | to say   |\n"

    it "accepts rows/cols of varying length" $ do
      layoutTable [
                    ["Col 1",    "Col 2"          ],
                    ["Not much", "to say", "hehe!"],
                    ["I'm out"]
                  ]
        `shouldBe` "| Col 1    | Col 2    |          |\n| -------- | -------- | -------- |\n| Not much | to say   | hehe!    |\n| I'm out  |          |          |\n"

    it "works with empty input" $ do
      layoutTable []         `shouldBe` ""
      layoutTable [[]]       `shouldBe` "|  |\n|  |\n"
      layoutTable [[""], []] `shouldBe` "|  |\n|  |\n|  |\n"
