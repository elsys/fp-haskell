<!--
    page_number:true
    *page_number:false
-->
<!--
```hs
import Data.List (isInfixOf)

contains = isInfixOf
```
-->


Currying & Composition
=====

<br>

Георги Наков, [nakov.gl at gmail com](mailto:nakov.gl+tues@gmail.com)  
Марин Маринов, [marinov.ms+tues at gmail com](mailto:marinov.ms+tues@gmail.com)


Технологично училище "Електронни Системи"  
18 Януари 2017г.

---

## Защо?

Основна цел на Haskell е програмирането чрез генерични, преизползваеми компоненти. Тези компоненти се използват в "поточна линия" - поредица от трансофрмации на дадена задачата към нейното решение. Този стил на програмиране изисква "слепващи средства", които да осигурят потока на данни между компонентите, да спестят на програмиста писане на "глупав" повтарящ се код и да направят крайния резултат синтактично и визуално приятен.

---

## Пример

Откриване на броя редове, които се съдържат _Curry_

В `bash`:
```bash
cat composition-currying.md | grep Curry | wc -l
```

<br>В `haskell`
```hs
curryLns :: String -> Int
curryLns = length . filter (contains "Curry") . unlines 
```

---

## Пример ...

За преброяването на редовете съдържащи "Curry" използвахме прост алгоритъм:
 - разделихме входа на редове
 - оставихме само редовете, които съдържат низът "Curry"
 - преброихме колко редове са останали

---

## Приложение в Unix

Принципи на Unix приложенията:
 - правят едно нещо, но го правят добре
 - по-сложните програми са композиция на по-прости
 - ново-добавените средства се интегрират лесно със съществуващите посредством общ интерфейс - файлове
 - това позволява лесна работа, гъвкавост и продуктивност

---

## Механизмът за слепване

 - В Unix взаимоработата на две приложения става чрез писане и четене на файлове.
 - `bash`, `sh` и дригите shells предоставя удобен начин за пренасочване на `stdin` и `stdout` посредством `|`.
 - `|` _"свързва"_ стандарния изход на предходната програма със стандартния вход на последващата, ефективно създавайки еднопосочен канал за предаване на информация.

---

## Механизми за слепване - Haskell

 - Haskell предоставя два основни механизма се слепване - _currying_ и _function composition_.
 - тези механизми спомагат за синатктично лесно и визуално приятно преизползване на готови функци
 - това е основната причина защо Haskell програмите обикновено са по-генерични от анаглогична програма в друг език

---

## Currying

 - В Haskell всяка функция има **само 1 параметър**
 - функциите на много параметри са _syntactic sugar_ за **вложени функции с по един парамеър**

<br>

```hs
add :: Int -> Int
add x y = x + y

addLam :: Int -> Int
addLam = \x -> \y -> x + y
```

---

## Curryin - пример

```hs     
add :: Int -> Int
add x y = x + y

addLam :: Int -> Int
addLam = \x -> \y -> x + y
```

```hs
> add 4 5
-- (add 4) 5      <-  add' y = 4 + y
-- add' 5         <-  res    = 4 + 5
9

> addLam 4 5
-- (addLam 4) 5   <-  addLam' y = \y -> 4 + y
-- addLam' 5      <-  res       = 4 + 5
9
```

---

## Currying - сигнатури

Автоматичният Currying е причината сигнатурите да изглеждат по начина по който ги познаваме. Всичко това са били функциии!!

Всяко предаване на параметър ни връща нова функция. Това е и причината да трябва да ограждаме функционалните типове в скоби - казваме "хей, искам цялото това да е 1 параметър".

```hs
add3 :: Int -> (Int -> (Int -> Int)) -- default
add3 x y z = x + y + z

add2 :: Int -> Int -> Int
add2 = add3 0       -- same as \y -> \z -> 0 + y + z

apply :: (a -> b) -> a -> b
apply f a = f a
```

---

## Composition

Композицията е `|` във функционалните езици. Целта му е слепване на изхода на една фунцкия с входа на друга.

Ако имаме функциите:
```hs
g :: Int -> Double
g = fromInteger
```
```hs
f :: Double -> String
f = show
```

То композицията им е функцията:
```hs
c :: Int -> String
c x = f (g x)
```

---

## Composition ..

Haskell Prelude предоставя оператор за композиция.

```hs
(.) :: (b -> c) -> (a -> b) -> (a -> c)
f . g = \x -> f (g x)
```

```hs     
test  x = show (length x)
test' x = (show . length) x
```

<br>**Важно:** В Haskell (както и във физиката и математиката) композицията е обратна на тази в `bash`. Изразът се чете **от дясно на ляво**!

---

## Composition - Примери

```hs
> (length . unwords) "Hello world"
2

> map (even . length) ["hello", "world"]
[False, True]

> filter (odd . (+ 1)) [1..5]
[2, 4]

> head . filter (elem 'e') . unwords $ "hello world"
"hello"
```

---

## Операторът `$`

`$` е оператор за извикване на функция. Макар да изглежда като най-безсмисленият оператор (тъй като извикването става автоматично след _space_ `f x`), той е много полезен тъй като приоритетът му е много нисък (за разлика от _space_). Това позволява изпускане на скоби и е много удобно когато искаме да подадем на функция нещо като краен аргумент.

---

## Операторът `$` - примери

```hs
mul x y = x * y

> mul 3 $ 4     -- same as mul 3 4
12

> mul $ 3 $ 4   -- same as mul (3 4)
                -- whoops, 3 is not a function!
** Compile time error
```

---

## Операторът `$` - примери ..


```hs
> length . unwords $ "hi 5"
-- OK!  (length . unwords) "hi 5"
2

> length $ unwords $ "hi 5"
-- OK!  length (unwords "hi 5")
2

> (length $ unwords) $ "hi 5"
-- Fail!  (length unwords) <- unwords is not an array!
** Compile time error
```
```hs     
notCompose :: (b -> c) -> (a -> b) -> (a -> c)
notCompose f g = f $ g -- nope, we try to (f g)
```

---

## Sections

Секциите ни позволяват обръщане на оператор към функция. Същевременно може да подадем и ляв или десен аргумент.

```hs
myAdd = (+)

> myAdd 3 4
12

add42 = (+ 42)

> add42 10
52

> map (10 ^) . filter (> 0) $ [-2 .. 2]
[10, 100]
```

---

## Backticks

Позволяват ни да използваме функция, все едно е оператор!

```hs
vowels :: [Char]
vowels = ['a', 'e', 'i', 'o', 'u']

skipVowels :: String -> String
skipVowels x = filter (`elem` vowels) x
```

```hs
> (`elem` vowels) 'c'
False

> (`elem` vowels) 'a'
True

> skipVowels "Haskell is great"
"Hskll s grt"
```

---

## Изпускане на последенияте аргументи

```hs     
skipVowels :: String -> String
skipVowels x = filter (`elem` vowels) x
```

Е същото като:

```hs     
skipVowels' :: String -> String
skipVowels' = filter (`elem` vowels)
```

Тъй като
```hs     
filter :: [a -> Bool] -> [a]
```

<br>Всички функции са `curried`! Ние сме подали само един аргумент и ни е върната функция с оставащия!