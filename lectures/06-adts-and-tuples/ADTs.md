<!--
    page_number:true
    *page_number:false
-->
<!--
```hs
import Prelude hiding (length)

```
-->

Algebraic Data Types (ADTs)
====

<br>

Георги Наков, [nakov.gl at gmail com](mailto:nakov.gl+tues@gmail.com)  
Марин Маринов, [marinov.ms+tues at gmail com](mailto:marinov.ms+tues@gmail.com)


Технологично училище "Електронни Системи"  
23 Ноември 2016г.

---

## Какво са ADTs?

<br>

 - механизъм за създане на изброен тип - `enum`
 - механизъм за групиране на данни - `struct`
 - механизъм за създаване на изброен тип от групирани данни

---

## Защо ADTs?

<br>

 - компилаторът се оплаква ако всички случаи не са обработени
 - подпомагат описването на проблема като предварително очаквани ситуации
 - предпазват от подаване на невалидни данни

---

## ADTs като enum

Създаване на тип от предварително очаквани стойности. Компилаторът гарантира, че различна от изборените стойности не може да бъде присвоена на променлива от съответния тип.

<br>

```hs
data Answer = Yes | No

data CoinSides = Head | Tail

data DayOfWeek = Monday   | Tuesday | Wednesday |
                 Thursday | Friday  | Saturday  | Sunday
```

---

## Pattern matching

<br>

```hs
scottishAnswer :: Answer -> String
scottishAnswer Yes = "Ay!"
scottishAnswer No  = "Naw!"

> scottishAnswer Yes  -- using the value `Yes`
"Ay!"
```

```hs
isWeekend :: DayOfWeek -> Bool
isWeekend Saturday = True
isWeekend Sunday   = True
isWeekend _        = False

> isWeekend Monday  -- using the value `Monday`
False
```


---

## ADTs - групиране на данни

<br>

Също както `tuples` ADTs могат да се използват за групиране на данни. Разликата е, че те добавят и _"таг"_. По този начин две структури с еднакви подтипове, дори еднакви данни, се третират по различен начин.

<br>

**Синтаксис:**
```hs     
data URL = URLPath  String
--    |       |        |
--   Type    Tag   the value
```

---

## Създаване на стойности

Тагът също така се нарича _Value constructor_. Той се използва като функция и създава стойност от съответния тип.

<br>

```hs
data Password = PasswordText String
data Email    = EmailText    String

pwd :: Password
pwd = PasswordText "secure"

email :: Email
email = EmailText "john.doe@young-entrepreneur.com"
```

```hs     
email' :: Email
email' = PasswordText "jane.doe@gmail.com"  -- Error
```

---

## Създаване на стойности ...

<br>

**Важно:** _Value_ конструкторът не е тип!

```hs     
asEmail :: String -> EmailText  -- Error!
asEmail str = EmailText str
```

---

## Pattern matching - destructuring

<br>

```hs
--            Tag    x     y
data Point = Point  Int   Int

zero :: Point
zero = Point 0 0

translateX :: Int -> Point -> Point
translateX offset (Point x y) = Point (x + offset) y
```

<br>**Важно:** В случая `Point` се използва в 2 контекта - за създаване на стойност `Point 0 0` и като тип `zero :: Point`. Това е чест прийом, когато съществува само една дефиниция.

---

## ADTs - изброени групирани стойности

Силата на ADTs е в комбиниране на предходните две употреби. Така се създава комбинация от очаквани ситуации, които могат да носят и контекст (данни) със себе си.

<br>

```hs
--                             longitude  latitude
data Coordinates = Coordinates    Int        Int

--                           city   street   #
data Address = TextAddress  String  String  Int
             | Location     Coordinates
```

---

## ADTs - рекурсивни типове

Value конструкторите могат да реферират към типа за създаване на вгнездени, рекурсивни структури.


```hs
data XMLElement = Text String
                | Tag  String XMLElement


stringify :: XMLElement -> String
stringify (Text text)  = text
stringify (Tag tag el) = open ++ stringify el ++ close
    where open  = "<"  ++ tag ++ ">"
          close = "</" ++ tag ++ ">"
```
<br>

```hs
> stringify (Tag "book" (Tag "title" (Text "1984")))
"<book><title>1984</title></book>" 
```

---

## Автоматично генериране на Eq

Тъй като ADT стойностите са предварително дефинирани, нормално очакване е да могат да бъдат сравнявани с `==`. Това по подразбиране не е така, но тъй като те са _immutable_ Haskell може автоматично да генерира кода за сравнение. Това става чрез ключовата дума `deriving`.

---

## Автоматично генериране на Eq - пример

```hs
data Color = Red
           | Green
           | Blue
           | RGB Int Int Int
           deriving (Eq)

isBlack :: Color -> Bool
isBlack (RGB 0 0 0) = True
isBlack _           = False
```

```hs
> Red == Red
True

> RGB 11 22 33  == RGB 11 22 33
True

> isBlack (RGB 0 0 0)
True
```

