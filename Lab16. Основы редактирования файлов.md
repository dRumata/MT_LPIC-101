## Практическая работа 16. 
## Загрузка системы.

# 3. Команды GNU и UNIX

## 3.8 Основы редактирования файлов (103.8 Basic file editing)

### Вопросы для самопроверки
1. `vi` наиболее часто используется в качестве редактора конфигурационных файлов и исходного кода, где отступы помогают выделять фрагменты текста. Выделение может быть отступлено влево при нажатии клавиши `<` и вправо при нажатии клавиши `>`. Какие клавиши следует нажать в обычном режиме, чтобы сделать отступ текущего выделения на три шага влево?
    <details>
    <summary>Вариант ответа</summary>

    Клавиши `3<`, что означает три шага влево.
    
    </details>
<br> 





2. Сеанс работы с `vi` был прерван неожиданным отключением питания. При повторном открытии файла `vi` спрашивает пользователя, хочет ли он восстановить файл подкачки (автоматическую копию, созданную `vi`). Что нужно сделать, чтобы отказаться от файла подкачки?
    <details>
    <summary>Вариант ответа</summary>

    Нажать кнопку `d`, когда появится запрос `vi`.
    
    </details>
<br> 
   

---
### Практические задания
Скопируйте файл GPL-3 из сборника практических заданий или создайте файл с помощью следующей команды:

```bash
cat << 'EOF' > BSD
Copyright (c) The Regents of the University of California.
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions
are met:
1. Redistributions of source code must retain the above copyright
notice, this list of conditions and the following disclaimer.
1. Redistributions in binary form must reproduce the above copyright
notice, this list of conditions and the following disclaimer in the
documentation and/or other materials provided with the distribution.
1. Neither the name of the University nor the names of its contributors
may be used to endorse or promote products derived from this software
without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS'' AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
ARE DISCLAIMED.  IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
SUCH DAMAGE.
EOF
```

1. В обычном режиме `vi` можно выделить целую строку, нажав клавишу `V`. При этом в нее также включается завершающий символ новой строки. 

1.1 Откройте файл `vim BSD`

1.2 В обычном режиме, выделите строку от начального символа до символа новой строки, но не включая его:

Используйте Клавиши `0v$h`, что означает `0` ("переход к началу строки"), `v` ("начало выбора символа"), `$` ("переход к концу строки") и `h` ("возврат на одну позицию назад").

1.3 Завершите работу с файлом `:q!`
  
---
2. Откройте файл **~/BSD** и сразу перейти к последней строке:
```sh
vi + ~/BSD
```
2.1 Завершите работу с файлом `:q!`

---
3. Откройте файл **~/BSD** и сразу перейти к 8-й строке:
```sh
vi +8 ~/BSD
```
3.1 В обычном режиме `vi`, чтобы удалить символы от текущей позиции курсора до следующего символа точки

Клавиши `dt.`, означающие `d` ("начать удаление"), `t` ("перейти к следующему символу") и `.` (символ точки).

3.2 Завершите работу с файлом `:wq`

---
4. `vim` позволяет выделять блоки текста произвольной ширины, а не только участки с целыми строками. При нажатии `Ctrl-V` в обычном режиме выделение производится перемещением курсора вверх, вниз, влево и вправо. 

4.1 Откройте файл **~/BSD** и сразу перейти к 12-й строке:
```sh
vi +12 ~/BSD
```
4.1 Удалите блок, начинающийся с первого символа в текущей строке и содержащий следующие восемь колонок и пять строк текста

Комбинация `0`, `Ctrl-V` и `8l5jd` выделит и удалит соответствующий блок.

---
5. Перейдите в браузере на сайт https://vim-adventures.com и потратьте 15 минут на запоминание горячих клавиш vim во время игрового процесса.
---
