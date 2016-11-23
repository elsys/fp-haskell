<!--
    page_number:true
    *page_number:false
-->
<!--
```hs
import Prelude hiding (length)

```
-->
Tuples
====

<br>
<br>
<br>

Георги Наков, [nakov.gl at gmail com](mailto:nakov.gl+tues@gmail.com)  
Марин Маринов, [marinov.ms+tues at gmail com](mailto:marinov.ms+tues@gmail.com)


Технологично училище "Електронни Системи"  
23 Ноември 2016г.

---

## Tuples

Наредени n-торки:
### `(4.5, 0.0)`
### `("Ivan", 9, 5.35)`

- съставен тип данни (наподобява `struct` от C)
- "пакетира" няколко стойности в една
- разичават се от списъците
  - броят елементи е предварително известен и фиксиран
  - **не е нужно да са от един тип**

---

## Tuples - достъп

Съставните елементи нямат име, достъпът се извършва спрямо позиция.
За *наредени двойки* използваме :
`fst` - връща първия компонент
`snd` - връща втория компонент
```hs
> fst ("Does it work?", True)
  "Does it work?"

> snd ("Does it work?", True)
  True
```
 
---
## Tuples - pattern matching

За да вземем елементите на произволен tuple (не само двойки), ползваме **pattern matching**.

``` hs
f::(String, Int)->Int
f (x, y) = -- имплементация

g::(String, Int, Double) -> (String, Bool) -> String
g (_, _, theDouble) (theString, theBool) 
         =  -- имплементация

h:: [(Int, Int)] -> Int
h [(0,0)] = -- имплементация
h [(0, _):_] = -- имплементация
h ( (x,y) : xs) = -- имплементация

