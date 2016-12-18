Езика на разбойниците
====

## Описание
Много малки деца си измислят и използват *супер тайни езици*, за да крият информация и объркват родителите си.  По всяка вероятност всеки може да се сети за поне няколко такива (например *пилешки говор* на български); явлението е толкова разпространено, че Wikipedia дори има [списък на най-известните такива езици](https://en.wikipedia.org/wiki/Language_game#List_of_common_language_games).

<p align="center">
  <img src="http://i.imgur.com/P5z59Xl.png" width="700"/>
</p>

Това е Rövarspråket, шведски вариант на тази игра, в превод *езика на разбойниците*. Rövarspråket е доста прост - взимате нормална дума, удвоявате всяка съгласна и добавяте *o* помежду им. Така съгласната `b` става `bob`, `r` - `ror` и т.н. Гласните и пунктуацията остават непроменени.  

Напишете програма, коята кодира низ нормален текст на тайния Rövarspråket.

## Примерен вход и изход
Вход:  
`I'm speaking Robber's language!`  
Изход:  
`I'mom sospopeakokinongog Rorobobboberor'sos lolanongoguagoge!`

## Бонус #1

Уверете се, че програмата ви работи правилно с главни букви. Така например `Hello` трябва да се преведе до `Hohelollolo`, а не `HoHelollolо`. Вижте функцията `toLower` в модула `Data.Char` и как може да я импортирате.

## Бонус #2**

Напишете функция, която декодира низ обратно към нормален език *(допуснете, че даденият текст е във валиден Rövarspråket)*. Замислете се как бихте имплементирали и използвали функция `dropN`, която пропуска първите *n* символа от низ.

## Бележки
След като сте разкрили една шведска тайна, е време да преминете към следващата - [Surströmming](https://www.youtube.com/watch?v=wapOib5u8a8) (чудя се това дали изобщо да го има).