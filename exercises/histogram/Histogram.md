<!--
```hs
import Histogram

```
-->


Histogram
====


Напишете функция `histogram:: [Int] -> String`, която приема списък от числа и връща вертикална [хистограма](https://en.wikipedia.org/wiki/Histogram) на честотата на числата в дадения списък. Приемeтe, че входът ще съдържа само числа между 0 и 9 *(няма нужда да проверявате това)*. Изходния низ трябва да съвпада точно с показаните примери отдолу.


## Примерен вход и изход

```hs-io
> putStr (histogram [1,1,3])
 *        
 * *      
0123456789
```

```hs-io
> putStr (histogram [1,0,3,4,4,5,6,4,5,8,9,8,1])
    *     
 *  **  * 
** **** **
0123456789
```  
