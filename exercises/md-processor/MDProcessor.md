<!--
```hs
import MDProcessor

```
-->

Markdown
====

## Описание
**Markdown** e лесен и лек markup език. С него може да пишете `readme` файлове в *Github*, като предавате домашните си (бел. ред. *ако предавате*)!
**Markdown** има прост синтаксис и поддържа няколко основни операции за стилизиране на текст:
  - обикновния текст се пише директно. Нов ред започва след два `space`-а.
  - **bold** текст се огражда с `**` (*пример:* `**текст**`)
  - _italic_ текст се огражда с `_` (*пример:* `_текст_`)
  - заглавията се пишат с `#`(последван от `space`) и са 4 размера:
    - # Огромен - `# огромен`
    - ## Голям - `## голям`
    - ### Среден - `### среден`
    - #### Малък - `#### малък`
  - `блок от код`, който се oгражда с ` ``` `.  След отварящите ` ``` ` може да напишем и на какъв език е кода (*пример:* ` ```c `), за да имаме правилно оцветяване на синтаксиса
  - списъци
    - неномерирани - всеки елемент от списъка е на нов ред започващ с `-` (последван от `space`) (*пример:* `- елемент`)
    1. номериран - всеки елемент от списъка е на нов ред започващ с `число.` (последван от `space`) (*пример:* `1. първи елемент`)  
  Списъците могат да се вгнездват.  
  - Хоризонтална линия  - `---`:
  ---

## Задача 1
Моделирайте синтаксиса на markdown с `ADT` `data Element` (използвайте повече от 1 `ADT`, ако се налага). Вземете предвид, че даден елемент може да е едновременно и **bold**, и _italic_ - `_**eто така**_`.

#### Решение:

```hs     
data Lang = Haskell | C | Python | None deriving (Eq, Show)
data HeadingSize = H1 | H2 | H3 | H4 deriving (Eq, Show)
data ListMode = Ordered | Unordered deriving (Eq, Show)

data Element =
        Text String
      | Bold Element
      | Italic Element
      | Underline Element
      | Heading HeadingSize String
      | CodeBlock Lang [String]
      | List ListMode [Element]
      | HorizontalRule
      deriving (Eq, Show)
```

## Задача 2
Напишете функция `render2md :: Element -> String`. Тя ще взима единичен елемент и ще връща подходящото му текстово представяне (описано по-горе).

#### Примерен изход
```hs
> render2md (Bold (Text "This is a text"))
"**This is a text**"

> render2md HorizontalRule
"---"
```

## Задача 3
Напишете функция `render2html :: Element -> String`, която работи по същия начин както `render2md`, но генерира `html`.

#### Примерен изход

```hs     
> render2html (Bold (Text "This is a text"))
"<b>This is a text</b>"

> render2html HorizontalRule
"<hr/>"
```

## Задача 4
Напишете функция `robberify :: Element -> Element`. Тя ще взима елемент и ще връща текста, кодиран в [Robber's language](../secret-lang/Secret-lang.md) (`map`-ваме `robberify` в/у `Element`). Aко елементът не е текстов или е `code block`, остава същия.

#### Примерен изход
```hs     
> render2md (robberify (Bold (Text "This is a text")))
"**Tothohisos isos a totexoxtot**"

> render2md (robberify HorizontalRule)
"---"
```

## Задача 5
Напишете функция `toc :: [Element] -> Element` (*`Toc` e съкратено oт `table of contents` и e списък със съдържанието напр. в книги, учебници*). `toc` ще получава списък от елементи и ще генерира номериран списък със съдържание, като елементите му ще бъдат всички `H4` заглавия.

#### Примерен изход
```hs     
myDoc = [Heading H4 "Markdown processor",
         Heading H2 "Basics"
         Text "Markdown is a lightweight markup language with plain text formatting syntax",
         Heading H4 "Markdown syntax"]

> toc myDoc
List Ordered [ Text "Markdown processor", Text "Markdown syntax"]

> render2md (toc myDoc)
1. Markdown processor
2. Markdown syntax
```
