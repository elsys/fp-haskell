<!--
    page_number:true
    *page_number:false
-->

Локални променливи<br/>let и where
==

<br>

Георги Наков, [nakov.gl at gmail com](mailto:nakov.gl+tues@gmail.com)  
Марин Маринов, [marinov.ms+tues at gmail com](mailto:marinov.ms+tues@gmail.com)

Технологично училище "Електронни Системи"  
19 Октомври 2016г.

---

## Защо локални променливи
<br>

Локалните променливи са нужни за:
 - запазване на междинни стойности в сложни функции
 - създаване на локални, недостъпни отвън helper functions

---

## Локални променливи - синтаксис

<br>Два възможни вариантa: 

**let** синтаксис:
```hs
sumTimesTen x y = let s = x + y
                   in s * 10
```

**where** синтаксис:
```hs
sumTimesTen' x y = s * 10
    where s = x + y
```
<br>**Важно:** В идиоматичния Haskell `where` е по-често срещан `let`.

---

## Локални променливи - guards

Променливите въведени с `where` могат да бъдат ползвани и в guards на съответната дефиниция.

<br>

```hs
passwordStrength :: String -> String
passwordStrength [] = "Please enter a password"

passwordStrength pwd | len < 5   = "Weak"
                     | len < 8   = "Medium"
                     | otherwise = "Strong"

    where len = length pwd
```

---

## Локални променливи - видимост

Редът на деклариране на променливите не е от значение. Всяка една от въведените променливи, може да реферира всяка друга (също както top-level дефинициите в сорс файла).

<br>

```hs
multSign :: [Int] -> String
multSign ints
    | length ints /= 2 = "Don't know"
    | isXNeg == isYNeg = "Positive"
    | otherwise        = "Negative"

    where isXNeg = x < 0
          isYNeg = y < 0

          [x, y] = ints
```

**Важно:** Подравняването е от критично значение!

---

## Локални променливи - go функция

<br>

_helper_ функциите са идеален кандидат за локална променлива, тък като в повечето случаи те не са универсално приложими и очакват входа да е предварително валидиран.

<br>

```hs
maximum' :: [Int] -> Int
maximum' [] = error "empty list"
maximum' xs = go xs
    where go [m]    = m
          go (y:ys) = max y (go ys)
```
