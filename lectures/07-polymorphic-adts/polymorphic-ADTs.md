<!--
    page_number:true
    *page_number:false
-->
<!--
```hs
import Prelude hiding (Maybe(..))

```
-->

Параметричен полиморфизъм с Algebraic Data Types
====

<br>

Георги Наков, [nakov.gl at gmail com](mailto:nakov.gl+tues@gmail.com)  
Марин Маринов, [marinov.ms+tues at gmail com](mailto:marinov.ms+tues@gmail.com)


Технологично училище "Електронни Системи"  
30 Ноември 2016г.

---

## Box ADT

Да дефинираме тип, който държи проста стойност от произволен тип:
```hs
data IntHolder = IBox Int
-- IBox 5

data CharHolder = CBox Char
-- CBox 'a'

data StringHolder = SBox [Char]
-- SBox "hi"
```
<br/>

Отново същия проблем както и при функциите `reverseInt :: [Int] -> [Int]`, `reverseString :: [Char] -> [Char]` и тн.

---

## Параметричен полиморфизъм

Отново същото решение: вместо конкретен тип, ще използваме типов параметър `a` - `Box a`. 
```hs
data Holder a = Box a
```

**Важно**: Освен в конструкторите на стойност (`Box`), добавихме `a` и в декларацията на типа - `data Holder a`. Когато използваме типов параметър `a`, `Holder` вече не е валиден тип и не може да имаме стойности от него. Стойностите може да са `Holder Int`, `Holder Char`, `Holder [Double]`. 

---

## Примери

```hs     
data Holder a = Box a
```

```text
ghci> :t Box True
Box True :: Holder Bool

ghci> :t Box "Hi"
Box "Hi" :: Holder [Char]  

ghci> :t Box
Box :: a -> Holder a
```

Конструкторът на стойности `Box` всъщност е полиморфична функция, която приема един аргумент от тип `a` и връща `Holder a`.

---

## Примери

Много често използваме типови параметри, когато пишем *контейнери* за някакви стойности.
```hs
data List a = Empty | Cons a (List a)

data Tree v = EmptyNode | Node v (Tree v) (Tree v)

data Map k v = Map [(k, v)]
```

---

## Maybe a

```hs
data Maybe a = Nothing | Just a
```

Най-често използваме `Maybe a`, когато искаме да различаваме между валидни стойности от даден тип или грешка.

```hs
mySqrt :: Double -> Maybe Double
mySqrt x 
  | x < 0     = Nothing
  | otherwise = Just (sqrt x)

safeHead :: [a] -> Maybe a
safeHead []    = Nothing
safeHead (x:_) = Just x
```
