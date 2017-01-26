<!--
    page_number:true
    *page_number:false
-->

Входно-изходни операции
=====

<br>

Георги Наков, [nakov.gl at gmail com](mailto:nakov.gl+tues@gmail.com)  
Марин Маринов, [marinov.ms+tues at gmail com](mailto:marinov.ms+tues@gmail.com)


Технологично училище "Електронни Системи"  
25 Януари 2017г.

---

## IO в Haskell

```hs     
main :: IO ()
main = putStrLn "Hello"
```

`IO a` е тип, който описва действия, които имат странични ефекти и могат да продуцират стойност от тип `a`.

`main` продуцира `()` - еквивалента на `void` в Haskell.

Само `main` може да изпълнява тези действия.

---

## IO в Haskell

По подразбиране main може да изпълни само едно действие. За да групираме няколко използваме `dо` синтаксис.

```hs     
main = do
   putStrLn "Hi"
   putStrLn "Hello again"
```

---

## IO в Haskell

Дейстивята с тип `IO a` освен странични ефекти, могат да продуцират произволни стойности.

За да се доберем до стойността, използваме оператора `<-` в `do` block. Той присвоява резултата на променлива.

```hs     
getLine :: IO String
```
```hs     
main = do
   name <- getLine
   putStrLn $ "Hi " ++ name
```

**Важно:** `IO String` не е `String`! Не може да го използваме директно във функция, която очаква `String`!

---

## IO в Haskell - връщане на резултат

За да върнем резултат използваме `return :: a -> IO a`.

```hs     
fileLength :: String -> IO Int
fileLength fileName = do contents <- readFile fileName
                         return (length contents)

main = do len <- fileLength "test.hs"

          putStr   "test.hs is "
          putStr   (show len)
          putStrLn " bytes long"
```

**Важно:** `return` е функция (макар специална)! `return 1 + 2` не работи. Използвайте скоби за задаване на нужния приоритет. 

---

## IO в Haskell

Понякога се налага да създадем *кухо* действие. За целта ползваме `return ()`

```hs    
main = do
   password <- getLine
   if password == "test"
      then do 
        putStrLn "Choose more secure pass"
        putStrLn "Access granted though"
      else
        return ()
```

И двете части на `if` трябва да имат еднакъв тип! В случая това е `IO ()`. Ако типът беше `IO Int`, то не може да ползваме `return ()`, а трябва `return 0` или друго валидно число!
