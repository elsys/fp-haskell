Функционална геометрия
====
<br>
Ще разгледаме как от прости базови форми можем да получим сложни крайни изображение само с помощта на малко на брой лесно геометрични трансформации.

<p align="center">
  <img src="./sides.svg" width="400"/>
</p>
За тази цел ще използваме библиотеката [*Diagrams*](http://projects.haskell.org/diagrams/), както и допълнителния проект към нея [*Diagrams-input*](https://github.com/diagrams/diagrams-input) за четене на SVG файлове.

## QuickStart
1. Сваляме [Funcgeo](./) и отиваме в директорията
2. Изпълняваме
```
cabal sandbox init
```
С тази команда инициализираме *виртуална среда (sandbox)*, в която cabal ще инсталира Haskell пакетите. Така избягваме възможността да омажем системната инсталация и нейните пакети
3. Сваляме [*Diagrams-input*](https://github.com/diagrams/diagrams-input) и местим папката `diagrams-input-master` като поддиректория в папката `funcgeo`
4. От основната папка на `funcgeo` изпъляваме
```
cabal install diagrams-input-master/diagrams-input.cabal
```
и чакаме *много*! *За да забързаме, може да подадем аргумента -jN, където N са броя ядра*
5. В `funcgeo` папката изпълняваме, за да свалим всички dependecy-та на проекта (най-вече [*Diagrams*](http://projects.haskell.org/diagrams/))
```
cabal install
```
Чакаме много!
6. Изпъляваме
```
 cabal run -- -o a.svg -w 600 && firefox a.svg
```
`-o ` флагът указва къде да запишем изображението, а `-w` широчината му. Очакваме да видим `a.svg` да е просто копие на `fish.svg`.  
Toва e единичният елемент, който ще трансформираме.

<img src="./a.svg" width="400"/>
