<!--
    page_number:true
    *page_number:false
-->

Въведение част 2<br/>Lists, Guards and Pattern matching
====

<br>
<br>
<br>

Георги Наков, [nakov.gl at gmail com](mailto:nakov.gl+tues@gmail.com)  
Марин Маринов, [marinov.ms+tues at gmail com](mailto:marinov.ms+tues@gmail.com)

Технологично училище "Електронни Системи"  
26 Октомври 2016г.

---

## Дефиниране на частни случаи

Може да имаме отделни случаи (с различно тяло) за конкретни стойности на аргументите на функция.
<br>
```hs
guessTheNumber :: Int -> String
guessTheNumber 42 = "Got it right, pal!"
guessTheNumber  x = "Try again"
```

---
## Дефиниране на частни случаи...

Наподобяват много на `if`. Какво печелим?
- много четим и лесен за разбиране код
- пишем по-малко
- декларативен стил
- логическо отделяне на *по-специалните* случаи (*corner cases* - *ако аргументът е нула, ако низът е празен, ако масивът няма елементи*)

---

## Дефиниране на частни случаи...

Формулата за функцията на Fibonacci е:
<pre>
F<sub>0</sub> = 0
F<sub>1</sub> = 1
F<sub>n</sub> = F(n-1) + F(n-2)
</pre>

<br>Транслирана в код на Haskell:
```hs
fib :: Int -> Int
fib 0 = 0
fib 1 = 1
fib n = fib (n - 1) + fib (n - 2)
```

---

## Дефиниране на частни случаи...

Работят и за функции с повече от един аргумент:
```
grades :: Int -> Int -> String
grades 2      2        = "Absolute zero!"
grades theory 2        = "Solve more problems!"
grades 2      practice = "Study more!"
grades theory practice = "Passable!"
```
Проверяват се линейно - от първия ред към последния; ако има съвпадение, се изпълнява само тялото за конкретния случай, т.е **редът има значение!**
Дефиницията само с променливи е възможно най-генералният случай.

---

## Списъци (*a.k.a листове*)

<br>
Едносвързаният списък е основна структура във функционалните езици.
<br><br>
<p align="center">
  <img src="./linked-list.png" width="650"/>
</p>

Защо списък?
 - евтино, без мутация добавяне в началото
 - натурално приляга на рекурсивни решения

---

## Списъци - синтаксис

Наподобяват много масивите от императивните езици!


- празен списък
```hs
emptyList :: [Int]
emptyList = []
```
- непразен списък
``` hs
listOfNums :: [Int]
listOfNums = [1, 2, 3, 4]
```

<br>**Важно**: Типът **не е `Int[]`**, а е **`[Int]`**!

---

## Списъци - добавяне на елемент

Операцията по добавяне на нов елемент отпред на списъка е се нарича `cons`. Произлиза от думата `construct` и е наследство от Lisp - първият език, който ги вкарва в масова употреба.

Haskell притежава удобен синтаксис - `value : list` (":" се чете cons)
```hs
> 1 : [2, 3, 4]
[1, 2, 3, 4]

> 1 : 2 : 3 : 4 : []
[1, 2, 3, 4]
```

---

## Списъци...

Когато използваме ":" многократно, скоби не са нужни.  
*(или казваме, че `cons` е дясно асоциативна и с нисък приоритет)*


```hs
> 1:2:3:4:[]       == [1, 2, 3, 4]
True

> 1:(2:(3:(4:[]))) == [1, 2, 3, 4]
True

> 1 + 2 : 3 : quot 4 2 : []
  -- (1 + 2) : 3 : (quot 4 2) : []
[3, 3, 2]
```

<br>**Важно:** Всъщност синтаксисът `[1, 2, 3, 4]` е само удобство (_syntactic sugar_), който компилаторът свежда до `1:2:3:4:[]`.

---

## Списъци - други операции

Трите базови операции върху едносвързан списък са:
 - добавяне на елемент в началото (`cons`, `:`)
 - проверка дали списъкът е празен (`[]`)
 - разделяне на списъка на глава и останала част
   ```hs     
   x : xs <-- останала част (също е списък)
   |   
   глава
   ```

**Важно:** Записът `x:xs` - списък с поне един елемент `х`. `xs` е списък с останалите елементи (или празен - `[]`).
`[x, xs]` - списък с точно два елемента `x` и `xs`!

---


## Типът String

Типът `String` е просто списък от символи - `[Char]`. Логически е доста близък до този в C, с разликата, че в Haskell не е null терминиран масив, а едносвързан списък.

<br>

```hs
str :: String
str = "string"

str' :: [Char]
str' = "string"

str'' :: [Char]
str'' = 's':'t':'r':'i':'n':'g':[]

> str == str' && str == str''
True
```

---

## Pattern matching

- декларативен стил на програмиране. 
- целта е имплементиране на функциите като дефиниции за различни случаи, а не като поредица от действия.
- задаваме *шаблон*, срещу който се съпоставят входните данни (аргументите) на функцията:  
  - ако има съвпадение - изпълняваме тялото; 
  - ако не - продължваме надолу със следващия *шаблон* (ако има) или приключваме без резултат.  

Средството, което Haskell предоставя, се нарича pattern matching.

---

## Pattern matching...

- генерализация на частните случаи на функции
- *шаблонът* - дефинира структурата на данните, тества как са били създадани 
- допълнително ни дава възможност да *деконструираме* сложна стойност - да вземем отделни подчасти в нея като променливи
- при прости типове - съвпада с частните случаи
- при сложни типове (списък)....

---

## Pattern matching - прости типове ...

```hs     
fib :: Int -> Int
fib 0 = 0
fib 1 = 1
fib n = fib (n - 1) + fib (n - 2)
```

<br>`fib 0`, `fib 1` правят pattern matching по съответна стойност. `0` и `1` са patterns - съответните константи.
<br>`fib n` - тук pattern е именоването на входа, т.е. декларираме че всеки друг вход ще наричаме `n`. Или погледнато по-просто, казваме че входът е променливата `n`, ако не е някой от предходните случаи.

---

## Pattern matching - листове

Два основни шаблона за тестване:
- `[]` - празен списък
-  `(x:xs)` - списък с първи елемент `x`
<br>

```hs
restOrEmpty :: [Int] -> [Int]
restOrEmpty []     = []
restOrEmpty (x:xs) = xs

firstOrDefault :: Int -> [Int] -> Int
firstOrDefault def []     = def -- empty list
firstOrDefault def (x:xs) = x
```
<!--
  lecturer note:
    - `firstOrDefault` vs `head`
    - `restOrEmpty` vs `tail`
  
  ask students what do they expect from
  head :: [Int] -> Int
-->

---

## Пример - дължина на списък

Дължина на списък:
```hs
intListLength :: [Int] -> Int
intListLength []     = 0
intListLength (x:xs) = 1 + intListLength xs

> intListLength []
0

> intListLength [1, 2, 3, 4]
4
```

<br>**Hint:** Haskell има вградена функция за изчисляване дължината на списък от произволен тип - `length`.


---

## Работа със списъци

Много чест прийом при работата със списъци е:
```hs     
work [] = []
work (x:xs) = f x : (work xs)
```
<br>

### Пример - числа на квадрат
```hs
squared :: [Int]->[Int]
squared [] = []
squared (x:xs) = (x^2) : (squared xs)
```

---


## Pattern matching

Шаблоните могат да се влагат! Те не са ограничени до едно ниво - с тях могат да се създават произволни комбинации!

<br>

```hs
-- Look a list of lists of Int
isFirstDoubleZeroArray :: [[Int]] -> Bool
isFirstDoubleZeroArray ([0,0] : rest) = True
isFirstDoubleZeroArray xs             = False

isThird42 :: [Int] -> Bool
isThird42 (x:y:42:rest)  = True
isThird42 xs             = False
```

---

## Pattern matching - wildcard

В случаите, в които не ползваме променливата, е желателно да я именоваме `_`. `_` е специален pattern, който се тълкува като "игнорирай" или "не ме интересува". Само по себе си това не звучи много полезно, но помага на компилатора в създаване на по-лесно разбираеми диагностични съобщения и предпазване от механични грешки.
<br>

```hs
intToBool :: Int -> Bool
intToBool 0 = False
intToBool _ = True   -- everything other than 0
                     -- (we don't care exactly what)
```

---


## Guards

- наподобяват pattern matching
- за разлика от тях не тестват *структурата* на стойността, а някакво свойство; оценяват се до `True` или `False`
- отново подпомогат декларативния стил, правят кода по-четим и лесен и заместват `if`
---

## Пример - guards

```hs
ageism :: Int -> String
ageism x 
  | x < 2     = "Babyyyy!"
  | x < 10    = "Stay wild, child!"
  | x < 20    = "You're a rebel!"
  | otherwise = "You're a serious grown-up!"
```

Крайното условие на guards е препоръчително да е най-общият случай, като преди това са проверени конкретните изключения. Обикновено се ползва константата `otherwise`, но тя е просто псевдоним за `True`.


---

## Пример 2 - signum

Използването на guards е особено удобно, когато pattern matching не е възможен.

<br>

```hs
signum :: Int -> Int
signum x | x < 0  = -1
         | x == 0 = 0
         | x > 0  = 1
```
**Важно**: Забележете, че `=` стои след guard-а.

---


## guards - генерализиран синтаксис

```hs     
funName param
    | bool-condition    = specific-definition
     ....
    | bool-condition-n  = specific-definition-n
    | otherwise         = most-general-definition
```

<br>**Важно:** Критично важно е правилното подравняване! Компилаторът използва индентацията като маркер, че дефиницията на функцията продължава!

---

## Pattern matching и guards

Могат да се ползват заедно

```
isThirdEven :: [Int] -> Bool
isThirdEven (x:y:z:rest) | even z       = True
isThirdEven x            | length x > 2 = False
```

Ненапълно вярна функция, защото е непълнa. Какво става, ако я извикаме с `[1,2]` или `[]`

```text
Pattern match(es) are non-exhaustive
    In an equation for ‘isThirdEven’:
        Patterns not matched:
```

---


## Pattern matching и guards - strings

```hs
isKey :: String -> Bool
isKey "key"    = True
isKey ('K':xs) = True
isKey _        = False

reverseKeys :: String -> String
reverseKeys (x:y:z:rest)
    | isKey (x:y:z:[]) = z:y:x:(reverseKeys rest)

reverseKeys (x:rest)   = x : reverseKeys rest
reverseKeys []         = []

> reverseKeys "This is a Killer key"
"This is a liKler yek"
```
