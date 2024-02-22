## Практическая работа 22. 
## FHS, правила размещения файлов.

> Соответствие LPI101: (104.7 Find system files and place files in the correct location) 

### Вопросы для самопроверки

1. Представьте, что программе необходимо создать одноразовый временный файл, который больше никогда не понадобится после закрытия программы. В каком каталоге будет правильно создать этот файл?
<details>
    <summary>Вариант ответа</summary>
    
Поскольку после завершения работы программы файл нам не нужен, правильным каталогом будет **/tmp**.

</details>
<br>


2. Какой временный каталог должен быть очищен в процессе загрузки?
<details>
    <summary>Вариант ответа</summary>
Это каталог **/run** или, в некоторых системах, **/var/run**.
</details>
<br>


3. Какую переменную необходимо добавить в файл **/etc/updatedb.conf**, чтобы `updatedb` игнорировал файловые системы **ntfs**?
<details>
    <summary>Вариант ответа</summary>
Это переменная `PRUNEFS=`, за которой следует тип файловой системы: `PRUNEFS=ntfs`
</details>
<br>

4. Системный администратор хочет смонтировать внутренний диск **/dev/sdc1**. Согласно FHS, в каком каталоге должен быть смонтирован этот диск?
<details>
    <summary>Вариант ответа</summary>
На практике диск может быть смонтирован в любом месте. Однако FHS рекомендует выполнять временное монтирование в каталоге **/mnt**
</details>
<br>


5. Предположим, что пользователи **Carol** и **john** входят в группу **mkt**. Найдите в домашнем каталоге Джона все файлы, которые также доступны для чтения Кэрол.

<details>
    <summary>Вариант ответа</summary>   
Учитывая, что они входят в одну группу, нам нужен хотя бы **r (4)** в групповых разрешениях, а остальные нас не волнуют. Итак:

```sh
find /home/john -perm -040
```
</details>
<br>

6.  Если ограничить поиск файловыми системами ext4, то в каталоге **/mnt** будут найдены все файлы, которые имеют как минимум права на выполнение для данной группы, доступны для чтения текущему пользователю и у которых за последние 2 часа был изменен какой-либо атрибут.
<details>
    <summary>Вариант ответа</summary> 
Используйте параметр `-fstype` в команде `find`, чтобы ограничить поиск файловыми системами определенных типов. Файл, читаемый текущим пользователем, будет иметь не менее 4 в первом разряде разрешений, а исполняемый группой - не менее 1 во втором разряде. Поскольку нам не важны разрешения для других, мы можем использовать 0 для третьего разряда. Для фильтрации последних изменений атрибутов используйте параметр `-cmin N`, помня, что `N` указывается в минутах. Таким образом:

```sh
find /mnt -fstype ext4 -perm -410 -cmin -120
```
</details>
<br>




---
### Практические задания
1. Используя команду `find`, найдите только в текущем каталоге файлы, которые доступны пользователю на запись, были изменены за последние 3 дня и имеют размер более 1 Mбайт.

Для этого вам понадобятся параметры `-writable`, `-mtime` и `-size`: 

```sh
find . -writable -mtime -3 -size +1M
```

---
2. Используя `locate`, найдите все файлы, содержащие в своих именах оба шаблона **report** и либо **updated**, либо **update**, либо **update** начиная с корневой директории


2.1 Перейдите в корневую директрию
```sh
cd /
```
2.2 Поскольку `locate` должен соответствовать всем шаблонам, используйте опцию `-A`:
```sh
locate -A "report" "updat"
```
Примерный вывод:
```sh
/home/student/.mozilla/firefox/zq4cy5ew.default-release/datareporting/glean/events/background-update
```
2.3 Найдите еще родну комбинацию, на этот раз **README** и **vim**
Примерный вывод:
```sh
/usr/share/doc/neovim/README.md
/usr/share/doc/vim-common/README.md
/usr/share/doc/vim-common/README.txt
/usr/share/doc/vim-common/README_VIM9.md
/usr/share/doc/vim-common/README_ami.txt
/usr/share/doc/vim-common/README_amibin.txt
/usr/share/doc/vim-common/README_amisrc.txt
/usr/share/doc/vim-common/README_bindos.txt
/usr/share/doc/vim-common/README_dos.txt
/usr/share/doc/vim-common/README_extra.txt
/usr/share/doc/vim-common/README_mac.txt
/usr/share/doc/vim-common/README_ole.txt
/usr/share/doc/vim-common/README_os2.txt
/usr/share/doc/vim-common/README_os390.txt
/usr/share/doc/vim-common/README_src.txt
/usr/share/doc/vim-common/README_srcdos.txt
/usr/share/doc/vim-common/README_unix.txt
/usr/share/doc/vim-common/README_vms.txt
/usr/share/doc/vim-common/README_w32s.txt
/usr/share/nvim/runtime/autoload/README.txt
/usr/share/nvim/runtime/colors/README.txt
```

---

3. Найдите где хранится **manpage** для `ifconfig`?

3.1 Используйте параметр `-m` для `whereis`:

```sh
whereis -m ifconfig
```
Примерный вывод:
```sh
ifconfig: /usr/share/man/man8/ifconfig.8.gz
```
3.2 Сравните с результатом команды
```sh
apropos ifconfig

ifconfig (8)         - configure a network interface
```
3.3. Оба результата указывавют на 8-й раздел man. Какие документы содержит 8-й раздел man? Узнайте с помощью 
```sh
man man
```
```sh
DESCRIPTION
       man  is the system's manual pager.  Each page argument given to man is normally the name of a program, utility or function.  The manual page associated
       with each of these arguments is then found and displayed.  A section, if provided, will direct man to look only in that section of the manual.  The de‐
       fault action is to search in all of the available sections following a pre-defined order (see DEFAULTS), and to show only the first page found, even if
       page exists in several sections.

       The table below shows the section numbers of the manual followed by the types of pages they contain.

       1   Executable programs or shell commands
       2   System calls (functions provided by the kernel)
       3   Library calls (functions within program libraries)
       4   Special files (usually found in /dev)
       5   File formats and conventions, e.g. /etc/passwd
       6   Games
       7   Miscellaneous (including macro packages and conventions), e.g. man(7), groff(7), man-pages(7)
       8   System administration commands (usually only for root)
       9   Kernel routines [Non standard]

```
 

---
4. При использовании функции `locate` результаты поиска извлекаются из базы данных, формируемой программой `updatedb`. Однако эта база данных может быть устаревшей, что приводит к тому, что locate показывает файлы, которые уже не существуют
4.1 Заставьте `locate` показывать на выходе только существующие файлы
Добавьте к `locate` параметр `-e`, как показано ниже 

```sh
cd
locate -e -A "updat" "home"
```

4.2 Создайте файл в домашней директории и повторите предыдущий шаг
```sh
cd
touch update
locate -e -A "updat" "home"
```
вновь созданного файла нет!
4.3 Прочитайте документацию по locate и обновите базу данных о файлах
v

4.4 Вновь поищите файлы с патерном "updat" "home"
Файл должен быть виден
```console
/home/student/update
/home/student/.mozilla/firefox/zq4cy5ew.default-release/datareporting/glean/events/background-update
/home/student/MT_LPIC-101/.git/hooks/post-update.sample
/home/student/MT_LPIC-101/.git/hooks/update.sample
```
4.5 Удалите файл **~/update** и выполните поиск без ключа `-e`
```sh
rm -v update
locate -A "updat" "home"
```
Файл должен быть виден

4.6 Теперь выполните поиск с ключем `-e` 
Файл больше не выдается в списке найденых.


---
5. Необходимо найти в текущем каталоге или в подкаталогах до двух уровней ниже, исключая смонтированные файловые системы, все файлы, в именах которых встречается шаблон **Status** или **statute**.

5.1 Перейдите в корневую директрию
```sh
cd /
```

5.2 Помните, что для параметра `-maxdepth` необходимо учитывать и текущий каталог, поэтому мы хотим получить три уровня (текущий плюс 2 уровня вниз):

```sh
find . -maxdepth 3 -mount -iname "*statu*"
```
```console
find: ‘./etc/dhcp’: Permission denied
find: ‘./etc/credstore’: Permission denied
find: ‘./etc/grub.d’: Permission denied
find: ‘./etc/nftables’: Permission denied
./etc/sestatus.conf
find: ‘./etc/sssd’: Permission denied
find: ‘./etc/audit’: Permission denied
find: ‘./etc/sudoers.d’: Permission denied
find: ‘./etc/ipsec.d’: Permission denied
find: ‘./etc/firewalld’: Permission denied
find: ‘./etc/libvirt’: Permission denied
find: ‘./etc/BackupPC’: Permission denied
find: ‘./etc/credstore.encrypted’: Permission denied
find: ‘./root’: Permission denied
./usr/bin/tpm2_setcommandauditstatus
./usr/bin/sestatus
./usr/sbin/e2mmpstatus
./usr/sbin/sestatus
./usr/sbin/bcache-status
```

5.3 Как избавится от `Permission denied`? Два варианта: **sudo** - если надо искать в недоступных каталогах, **2>/dev/null** - если хотим игнорироввать ошибки.
Выполните оба варианта
```sh
sudo find . -maxdepth 3 -mount -iname "*statu*"
```
```sh
find . -maxdepth 3 -mount -iname "*statu*" 2>/dev/null
```

---
6.  Необходимо найти пустые файлы, которые были изменены более 2 дней назад и находятся не менее чем на два уровня ниже текущего каталога.

6.1 Параметр `-mindepth N` может быть использован для ограничения поиска не менее чем `N` уровнями ниже, но помните, что в подсчет необходимо включать текущий каталог. Параметр `-empty` используется для проверки пустых файлов, а `-mtime N` - для проверки времени модификации. Итак:

```sh
find . -mindepth 3 -empty -mtime +2 -type 
```

6.2 Что надо добавить для удаления этих файлов? Подсказка: смотрите `xargs`.

---