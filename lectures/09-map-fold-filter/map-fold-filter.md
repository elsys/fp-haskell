<!--
    page_number:true
    *page_number:false
-->
<!--
```hs
import Data.List (sortBy)
import Data.Char (toLower)

import Prelude hiding (map, filter, foldl, foldr)

sortWith :: (a -> a -> Bool) -> [a] -> [a]
sortWith f = sortBy (\x y -> if f x y then LT else GT)
```
-->

Функции от по-висок ред.
map, filter, fold
=====

<br>

Георги Наков, [nakov.gl at gmail com](mailto:nakov.gl+tues@gmail.com)  
Марин Маринов, [marinov.ms+tues at gmail com](mailto:marinov.ms+tues@gmail.com)


Технологично училище "Електронни Системи"  
21 Декември 2016г.

---

## Функции от по-висок ред

**Функциите са стойности** - може да ги подаваме като **аргументи на други функции**.

<br/>
В Haskell това става просто като подадем името на функцията.

```hs
myComparison x y = abs x <= abs y

> sortWith myComparison [-2, 1, 3, -11, -7]
[1, -2, 3, -7, -11]
```
За функциите, които приемат други функции като аргумент, казваме, че са от по-висок ред.


---

## Функции от по-висок ред - приложения

Използваме функции като аргументи, когато искаме да подадем _поведение_, а не проста стойност. Това се среща и в много императивни езици, когато не можем да контролираме последователността на събитията, например:
- какво да се случи като натиснем бутон
 ` button.onClick(function(e){ showList();... })`
- какво става, когато изтеглим файл
 `downloader.onFileDownloaded(function(f){writeToDisk(f)...});`

---

## Функции от по-висок ред

Какво можем да правим с функция подадена като аргумент?
**Да я извикаме / приложим!**
```hs     
calc op x y = op x y
```
```hs
myPlus :: Int -> Int -> Int
myPlus x y = x + y

myExpression :: Int -> Int -> Int
myExpression x y = x^2 + y^2

> calc myPlus 5 3
8

> calc myExpression 5 3
34
```

---

## Функции от по-висок ред - типове

Какъв е типът на функцията от по-висок ред `calc`?
```hs
calc :: (Int -> Int -> Int) -> Int -> Int -> Int
calc op x y = op x y

mySub :: Int -> Int -> Int
mySub x y = x - y
```
Типът на аргумента, който е функция, е самата **сигнатура на функцията, оградена в скоби**.

---

## Функции от по-висок ред - типове

```hs
applyNTimes :: (a -> a) -> Int -> a -> a
applyNTimes f 0 x = x
applyNTimes f n x = f (applyNTimes f (n-1) x)
-- f ( f ( f (f (f x)))) - n пъти

mul x = x * 5

> applyNTimes mul 3 2
250
```
В Haskell oбикновено слагаме функцията-аргумент на първо място - `applyNTimes f n x`, a не `applyNTimes n f x`.
```hs     
applyNTimes :: Int -> (a -> a) -> a -- странно!
applyNTimes n f x = -- странно!
```

---

## Анонимни функции
Понякога е досадно да дефинираме всеки път функция, само и единствено за да я подадем като аргумент.
- Един вариант е да използваме **`where`**
  ```hs     
  myOtherFunction :: Int -> Int
  myOtherFunction x = calc f x x
    where f x _ = x ^ 2
  ```
- Друг е да използваме **анонимна функция** (същото като **ламбда функция**).

---

## Aнонимни функции
```hs
myOtherFunction' :: Int -> Int
myOtherFunction' x = calc (\x _ -> x^2) x x
```
Синтаксисът е:
**`\param1 param2 ... paramN -> expression`**
<br/>

Използвайте ги само за прости функции и ги ограждайте в скоби!

---

## Секции

Може да предаваме директно **аритметични ф-ции, оператори за сравнение или булеви оператори** (Какво е общото? - **инфиксни са**), като дори може да зададем единия операнд - това се нарича секция.
**Примери:**
`(>5)` - булева ф-ция, която проверява дали число  е по-голямо от `5`
`(+5)` - ф-ция, която прибавя `5` към аргумента си
`(^2)` - вдигане на квадрат
`(2^)` - степенуване на `2` на степен  - аргумента.

```hs
> (2^) 3
8
```

---

## Функции от по-висок ред - map, filter, fold
В Haskell функциите от по-висок ред се свързват най-вече с 3 вградени функции:
- **`map`**
- **`filter`**
- **`fold`**

Те често заменят явната рекурсия и list comprehension и са предпочитания начин за работа със списъци. 

---

## map - трансформиране на списъци

`map` е функция, която се използва за трансформиране на всички елементи от даден списък.

```hs
> map show [1, 2, 3]
["1", "2", "3"]

> map toLower "CamelCase"
"camelcase"
```

<br>

```hs     
map :: (a -> b) -> [a] -> [b]
```

- `(a -> b)` - трансформираща функция `f`
- `[a]` - входен списък
- `[b]` - резултатен (трансформиран) списък

<br>

---

## map - пример

<br>

```hs
> map (^2) [1, 2, 3, 4]
[1, 4, 9, 16]

--             model   year
data Car = Car String  Int

getYear :: Car -> Int
getYear (Car _ year) = year

> map getYear [Car "Ford T" 1908, Car "Ford Focus" 1998]
[1908, 1998]
```

---

## map - пример №2

<br>

```hs
swearWords :: [String]
swearWords = [ "shit", "Java", "discount" ]

censorWord :: String -> String
censorWord word
    | elem word swearWords = map (\_ -> '*') word
    | otherwise            = word

censor :: String -> String
censor str = unwords censored
    where censored = map censorWord (words str)
```
```hs
> censor "I got a huge discount to Java island!"
"I got a huge ******** to **** island!"
```

---

## map - имплементация

<br>

```hs
map :: (a -> b) -> [a] -> [b]
map _ []     = []
map f (x:xs) = f x : map f xs
```

```hs
map' :: (a -> b) -> [a] -> [b]
map' f xs = [ f x | x <- xs ]
```

---

## filter - филтриране на спицъци

`filter` е функция, която се използва за премахване на всички елементи от списък, които не отговарят на дадено условие.

```hs
> filter odd [1, 2, 3, 4, 5]
[1, 3, 5] 
```
<br>

```hs     
filter :: (a -> Bool) -> [a] -> [a]
```

- `(a -> Bool)` - функция, чрез която се тестват елементите на списъка. Ако върне `True` за даден елемент той се запазва.
- `[a]` - входен списък
- `[a]` - резултатен (филтриран) списък

---

## filter - пример

```hs
data Item = Game String
          | Movie String
          deriving (Show, Eq)

items :: [Item]
items = [ Game "Hearth Stone",
          Game "Counter Strike",
          Movie "Lord of The Rings",
          Game "Solitaire",
          Movie "Inception" ]

isMovie :: Item -> Bool
isMovie (Movie _) = True
isMovie _         = False
```
```hs
> filter isMovie items
[ Movie "Lord of The Rings", Movie "Inception" ]
```

---

## filter - имплементация

<br>

```hs
filter :: (a -> Bool) -> [a] -> [a]
filter _ []     = []
filter f (x:xs) | f x       = x : filter f xs
                | otherwise = filter f xs
```

```hs
filter' :: (a -> Bool) -> [a] -> [a]
filter' f xs = [ x | x <- xs, f x ]
```

---

## Обхождане на списъци

Често се налага да се обходи целият списък и да извърши някакво действие за всеки от елементите му.
- В случаите, в които действието е **трансфoрмация на всеки елемент**, **`map`** е удобна възможност.
- Когато целта е **премахване на елементи, които не отговарят на дадено условие**, **`filter`** идва на помощ. 
- Остават случаите, в който стойността e използвана за някакъв резултат, различен от получаване на нов дериватен списък.

<!-- В тези случаи се ползват функциите `foldr` или `foldl`. -->

---

## Изграждане на интуиция - forEach

Функция за обхождане на всички елементи и извършване на някакво действие би изглеждала по следния начин.

```js
function forEach(list, f) {
    for (let i = 0; i < list.length; ++i) {
        let item = list[i];

        // do something useful with `item`
        f(item);
    }
}
```
```js
let sum = 0;
forEach([1, 2, 3], function(x) { sum += x });

> sum
6
```

---

## forEach в Haskell

```hs     
forEach :: (a -> #1 ) -> [a] -> #2
forEach f []     = #3
forEach f (x:xs) = (f x) #4 (forEach xs)
```

Няколко фундаментални проблема:
- #1 - стойност от какъв тип връща функцията `f`?
- #2 - стойност от какъв тип връща `forEach`?
- #3 - какво връща `forEach` при празен списък?
- #4 - как комбинираме резултата от `f` с последващите рекурсивни извиквания?

---

## forEach в Haskell - продължение

Основният проблем е, че Haskell не е императивен език и всяка функция трябва да върне резултат (а не `void`) и никоя функция не може да има странични ефекти. Поради тази причина простото обхождане на елементите и подаването им на функция "да ги разгледа" е безсмислено. Функцията трябва да ги _събере_ или _комбинира_ по някакъв начин.

Такава функция е `foldl`.

---

## foldl

`foldl` обхожда списъка **от ляво на дясно** и извиква функция за всеки от елементите му.

```hs
> foldl (+) 0 [1, 2, 3, 4]
10

> foldl (\acc x -> x:acc) [] [1, 2, 3, 4]
[4, 3, 2, 1]

> foldl (\acc x -> acc ++ x) "" ["a", "b", "c", "d"]
"abcd"
```

---

## foldl - сигнатура

```hs     
foldl :: (b -> a -> b) -> b -> [a] -> b
```

- `(b -> a -> b)` - функция, която се извиква с текущата акумулирана стойност и текущия елемент
- `b` - начална (акумулаторна) стойност
- `[a]` - входен списък
- `b` - краен / аргрегиран резултат

---

## foldl - графика

```hs    
foldl (+) 0 [1, 2, 3, 4]

0  [1,2,3,4]   -- 0                [1, 2, 3, 4]
 \ /  | | |
  +   | | |    -- (0 + 1)             [2, 3, 4]
   \ /  | |
    +   | |    -- ((0 + 1) + 2)          [3, 4]
     \ /  |
      +   |    -- (((0 + 1) + 2) + 3)       [4]
       \ /
        +      -- ((((0 + 1) + 2) + 3) + 4)  []
```

---

## foldl - пример

```hs
appendInt :: String -> Int -> String
appendInt acc i = acc ++ show i

> foldl appendInt "" [1, 2, 3]
-- foldl appendInt (appendInt "" 1) [2, 3]
--   foldl appendInt (appendInt "1" 2) [3]
--     foldl appendInt (appendInt "12" 3) []
"123"
```

---

## foldl - имплементация

```hs
foldl :: (b -> a -> b) -> b -> [a] -> b
foldl _ acc []     = acc
foldl f acc (x:xs) = foldl f (f acc x) xs
```

```hs
> foldl (+) 0 [1, 2, 3, 4]
-- foldl (+) (0+1) [2, 3, 4]
--   foldl (+) (1+2) [3, 4]
--     foldl (+) (3+3) [4]
--       foldl (+) (6+4) []
10
```

---

## foldr

`foldr` обхожда списъка **от дясно на ляво** и извиква функция за всеки от елементите му.

```hs
> foldr (+) 0 [1, 2, 3, 4]
10

> foldr (\x acc -> x:acc) [] [1, 2, 3, 4]
[1, 2, 3, 4]

> foldr (\x acc -> acc ++ x) "" ["a", "b", "c", "d"]
"dcba"
```

---

## foldr - сигнатура

```hs     
foldr :: (b -> a -> b) -> b -> [a] -> b
```

- `(a -> b -> b)` - функция, която се извиква с текущия елемент и текущата акумулирана стойност
- `b` - начална (акумулаторна) стойност
- `[a]` - входен списък
- `b` - краен / аргрегиран резултат

<br>

**Важно:** Акумулираната стойност и текущия елемент са с разменени позиции във `foldr` спрямо `foldl`.

---

## foldr - имплементация

```hs
foldr :: (a -> b -> b) -> b -> [a] -> b
foldr _ acc []     = acc
foldr f acc (x:xs) = f x (foldr f acc xs)
```

```hs
> foldr (+) 0 [1, 2, 3, 4]
-- 1 + foldr (+) 0 [2, 3, 4])
--   1 + (2 + foldr (+) 0 [3, 4])
--     1 + (2 + (3 + foldr (+) 0 [4]))
--       1 + (2 + (3 + (4 + foldr (+) 0 [])))
--         1 + (2 + (3 + (4 + 0)))
10
```

**Важно:** Тъй като Haskell е `lazy`, при еднаква сложност на подадената функция, `foldr` е по-оптимален спрямо `foldl`.

---

## Други функции от по-висок ред

Много от функциите в стандартната библиотека на Haskell (`Prelude`) имат и версии, в които подаваме допълнително функция като аргумент.

---

## zipWith

`zipWith :: (a -> b -> c) -> [a] -> [b] -> [c]`

Както `zip` (`zip [1,2,3] ["one", "two", "three"]`), но вместо да групираме елементите в`tuple`, прилагаме функция върху тях.

```hs
> zip ["hello ", "haskell "] ["world", "rules"]
[("hello ","world"),("haskell ","rules")]

> zipWith (++) ["hello ", "haskell "] ["world", "rules"]
["hello world" ,"haskell rules"]
```

---

## takeWhile и dropWhile
- `takeWhile :: (a -> Bool) -> [a] -> [a]`

  Като `take` (`take 2 [1..5]`), но вместо фиксиран брой,  взима елементи докато отговарят на дадено условие.

  ```hs
  > takeWhile (< 3) [1..5]
  [1, 2]
  ```

- `dropWhile :: (a -> Bool) -> [a] -> [a]`
  Като `drop` (`drop 2 [1..5]`), но вместо фиксиран брой,  пропуска елементи докато отговарят на дадено условие.
  ```hs
  > dropWhile (< 3) [1..5]
  [3, 4, 5]
  ```  

---

## any и all
- `any :: (a -> Bool) -> [a]-> Bool`

   `any` проверява дали има поне един елемент от списъка, който отговаря на дадено условие.

   ```hs
   > any (\x -> length x > 2) ["hi", "again", "!?"]
   True
   ```
- `all :: (a -> Bool) -> [a]-> Bool`

   `all` проверява дали всички елементи на списъка отговарят на дадено условие.

   ```hs
   > all (\x -> length x > 2) ["hi", "again", "!?"]
   False
   ```
