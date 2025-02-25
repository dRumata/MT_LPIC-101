## Практическая работа 8. 
## Управление общими библиотеками.

> Соответствие LPI101: (102.3 Manage shared libraries).

### Вопросы для самопроверки

1. Разделите следующие общие имена библиотек на их части:

| **Complete file name** | **Library name** | **so suffix** | **Version number** |
|------------------------|------------------|---------------|--------------------|
| linux-vdso.so.1        |                  |               |                    |
| libprocps.so.6         |                  |               |                    |
| libdl.so.2             |                  |               |                    |
| libc.so.6              |                  |               |                    |
| libsystemd.so.0        |                  |               |                    |
| ld-linux-x86-64.so.2   |                  |               |                    |

2. Вы разработали программное обеспечение и хотите добавить новый каталог общей библиотеки в свою систему **/opt/lib/mylib**. Вы записываете его абсолютный путь в файл под названием **mylib.conf**.
- В какой каталог следует поместить этот файл? 

    <details>
    <summary>Вариант ответа</summary>

    **/etc/ld.so.conf.d**
    
    </details>
<br> 

- Какую команду вы должны выполнить, чтобы сделать изменения полностью эффективными? 

    <details>
    <summary>Вариант ответа</summary>

    `ldconfig`
    
    </details>
<br> 


---
### Практические задания

1. Перечислите общие библиотеки, необходимые для команды `kill`?

1.1 Для получения информации используйте команду `ldd`
```sh
ldd /bin/kill
```
Вы должны получить ответ в виде трех библиотек

1.2 Получите справку по каждой библиотеке с помощью команд `apropos` и `man`
```
apropos vdso
apropos ld-linux
man vdso
man libc
man ld-linux
```
1.3 Прочтите описание этих библиотек и воспользуйтесь переводом документации о библиотеке vdso на странице https://ru.manpages.org/vdso/7

---
2. Получите информацию из объектных файлов об интересующих вас файлах. Используйте команду `objdump`.

2.1 Проверьте, установлена ли в вашей системе утилита `objdump`. Если нет, установите ее.
```sh
objdump -v
dnf install objdump
```
2.2 Найдите зависимости NEEDED для **libc**
- Используйте `objdump` с опцией `-p` (или `--private-headers`) и `grep` для в
```sh
objdump -p /lib/x86_64-linux-gnu/libc.so.6 | grep NEEDED
```
2.3 Если вы получили сообщение о неправильном пути, то уточните путь к файлу **libc.so.6**. Например, воспользовавшись командой и повторите предыдущий шаг для уточненного пути.
```sh
ldd /bin/bash
```

2.4 Найдите соназвания SONAME **libc**
- Используйте `objdump` с опцией `-p` (или `--private-headers`) и `grep` для вывода 
```sh
objdump -p /lib/x86_64-linux-gnu/libc.so.6 | grep SONAME
```

2.5 Найдите зависимости NEEDED для `bash`
- Используйте `objdump` с опцией `-p` (или `--private-headers`) и grep для вывода
```sh
objdump -p /bin/bash | grep NEEDED
```