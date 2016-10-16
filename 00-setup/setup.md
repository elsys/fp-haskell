# Функционално Програмиране с Haskell

Георги Наков, [mail@gmail.com](mailto:mail@gmail.com)  
Марин Маринов, [mail@abv.bg](mailto:mail@abv.bg)

Технологично училище "Електронни Системи"  
19 Октомври 2016г.

## Организационно
- 10 седмици
- 40 минути лекция + 40 минути упражнения
- линк към github репо-то
- (евентуално 'регистрационни' мейли?)
- (може би неща за някакъв по-голям проект?)

## Среда
- текстов редактор (autocomplete не е нужен!)
- [Haskell Platform 7.10.3](https://www.haskell.org/platform/)

## Инсталиране на Haskell Platform
- Mac   - [тук](https://www.haskell.org/platform/download/7.10.3/Haskell%20Platform%207.10.3%2064bit.pkg)
- Linux - [тук](https://www.haskell.org/platform/#linux), не сваляйте **Generic** версията  
  В Ubuntu или Mint може да изпълните директно:`$ sudo apt-get install haskell-platform`
- Windows - [тук](https://www.haskell.org/platform/download/7.10.3/HaskellPlatform-7.10.3-x86_64-setup.exe) + допълнителни стъпки:  
  Добавате следните редове в конфигурационния файл на **cabal** (може да видите къде се намира като изпълните `cabal user-config init` в терминал):
  ```
  extra-prog-path: C:\Program Files\Haskell Platform\7.10.3\msys\usr\bin  
  extra-lib-dirs: C:\Program Files\Haskell Platform\7.10.3\mingw\lib  
  extra-include-dirs: C:\Program Files\Haskell Platform\7.10.3\mingw\include
  ```

  *(не препоръчваме да използвате Windows)*