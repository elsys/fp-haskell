Имплементиране на прост интерпретатор
=====

---

## Какво е представляват програмите?

- текст написан в определена, предварително дефинирана граматика и синтаксис
- граматиката напомня на тази от часовете по Български, но е много по-проста и регулярна (няма изключения)
- синтакисът е ограничен и съдържа "ключови думи", които са запазени и имат специално значение

---

## Как от текст стигаме до изпълнение?

- първо трябва да разделими програмния текст на думи (също както и в естествения език)
- прилагайки правилата на граматиката трябва да създадем структури, които съдържат казаното (в натуралния език това е разпознаване на изречението като такова и разделянето му на подлог, сказуемо и пр.)
- ако казаното е граматически вярно, да се опитаме да го изпълним (да осмислим изречението и да изпълним това което е казано)

---

## Формални имена

Всеки от тези етапи си има формално име:
- разделянето на текста на думи - _лексически анализ_ или _tokenization_
- групиране и валидиране на думите спрямо граматиката - _parsing_
- изпълнението - _execution_ или _evaluation_

---

## Каква е разликата между интерпретатор и компилатор?

Времето на изпълнение!

| Интерпретатор  | Компилатор |
|----------------|------------|
| <ul><li>tokenization</li><li>parsing</li><li>evaluation</li></ul> | <ul><li>tokenization</li><li>parsing</li><li>creation of executable</li><li>.. running the executable by third parties</li></ul> |

---

## Пример

Прост език, който съдържа едиствено числа и събиране. Кодът е псевдо код.

---

## Tokenizer

```hs     
token ADD        = "+"
token (Number n) = one or more of ["0".."9"]

Tokens[] getTokens(String str) {
    Tokens[] result = [];

    loop {
      str = skipWhitespace(str);

      if (str is empty)
          if (result is empty)
             throw "Empty input"
          else return result

      if (str is "+":rest) 
          result.push(ADD), str = rest;

      if (str is digits:rest)
          result.push(Number digits), str = rest;
      
      throw "Not a valid token"
    }
}
```

---

## Parser

```hs
grammar Term = Number
             | Number "+" Term

data Expr = Const Number
          | Add Number Expr

Expr parse(Tokens[] toks) {
    if (toks is (n is Number):rest) {
       if (rest is "+":rest2)
           return Add n (parse rest2);
       
       if (rest is empty)
           return Const n
       
       throw "Extra input"
    }

    throw "Number expected"
}
```

---

## Резултати

```c
Input:  "1"
Tokens: [Number 1]
Parsed: Const (Number 1)

Input: "1 + 2 + 3"
Tokens: [Number 1, "+" Number 2, "+", Number 3]
Parsed: Add (Number 1) (Add (Number 2) (Number 3))

Input "1 + 2 + +"
Tokens: [Number 1, "+" Number 2, "+", "+"]
Parsed: throws "Number expected"
```