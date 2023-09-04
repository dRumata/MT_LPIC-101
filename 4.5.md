# 4. Устройства, файловые системы, FHS
## 4.5  Создание и изменение жестких и символических ссылок (104.6 Create and change hard and symbolic links)

### Вопросы для самопроверки

1. Каким параметром `chmod` в символьном режиме можно разрешить "липкий бит" для каталога?
<details>
    <summary>Вариант ответа</summary>
    
Символом "липкого" бита в символьном режиме является `t`. Поскольку мы хотим включить (добавить) это разрешение для каталога, параметр должен быть `+t`.

</details>
<br>

2. Рассмотрим следующие файлы:
```console
-rw-r--r-- 1 carol carol 19 Jun 24 11:12 clients.txt
lrwxrwxrwx 1 carol carol 11 Jun 24 11:13 partners.txt -> clients.txt
```

Каковы разрешения доступа к файлу **partners.txt**? Почему?
<details>
    <summary>Вариант ответа</summary>
Разрешения доступа для **partners.txt** - `rw-r-r--`, поскольку ссылки всегда наследуют те же разрешения доступа, что и цель.
</details>
<br>

3. Объясните разницу между жесткой ссылкой на файл и копией этого файла.
<details>
    <summary>Вариант ответа</summary>
Жесткая ссылка - это просто другое название файла. Несмотря на то, что она выглядит как дубликат оригинального файла, для всех целей и ссылка, и оригинал - одно и то же, поскольку они указывают на одни и те же данные на диске. Изменения, внесенные в содержимое ссылки, будут отражены на оригинале, и наоборот. Копия - это совершенно независимая сущность, занимающая другое место на диске. Изменения, внесенные в копию, не отразятся на оригинале, и наоборот.
</details>
<br>

4. Представьте, что к системе подключен флэш-накопитель, смонтированный в каталоге **/media/youruser/FlashA**. Вы хотите создать в своем домашнем каталоге ссылку **schematics.pdf**, указывающую на файл **esquema.pdf** в корне флэш-накопителя. Для этого вводите команду:

```sh
$ ln /media/youruser/FlashA/esquema.pdf ~/schematics.pdf
```
Что могло бы произойти? Почему?
<details>
    <summary>Вариант ответа</summary>
Команда завершится неудачей. Сообщение об ошибке будет иметь вид 
```console
Invalid cross-device link
```
и причина будет понятна: жесткие ссылки не могут указывать на цель в другом разделе или устройстве. Единственный способ создать такую ссылку - использовать символическую или мягкую ссылку, добавив к команде `ln` параметр `-s`.
</details>
<br>


5. Рассмотрим следующий вывод команды `ls -lah`:

```sh
$ ls -lah

total 3,1M
drwxr-xr-x 2 carol carol 4,0K jun 17 17:27 .
drwxr-xr-x 5 carol carol 4,0K jun 17 17:29 ..
-rw-rw-r-- 1 carol carol 2,8M jun 17 15:45 compressed.zip
-rw-r--r-- 4 carol carol 77K jun 17 17:25 document.txt
-rw-rw-r-- 1 carol carol 216K jun 17 17:25 image.png
-rw-r--r-- 4 carol carol 77K jun 17 17:25 text.txt
```

- Сколько ссылок указывает на файл **document.txt**?
<details>
    <summary>Вариант ответа</summary>
Каждый файл начинается с количества ссылок, равного `1`. Поскольку количество ссылок на этот файл равно `4`, на него указывают три ссылки.
</details>
<br>

- Это мягкие или жесткие ссылки?
<details>
    <summary>Вариант ответа</summary>
Это жесткие ссылки, так как мягкие ссылки не увеличивают количество ссылок на файл.
</details>
<br>

- Какой параметр следует передать программе `ls`, чтобы узнать, какой инод занимает каждый файл?
<details>
    <summary>Вариант ответа</summary>
Параметром является `-i`. Инод будет показан в качестве первого столбца в выводе `ls`, как показано ниже:

```sh
$ ls -lahi

total 3,1M
5388773 drwxr-xr-x 2 carol carol 4,0K jun 17 17:27 .
5245554 drwxr-xr-x 5 carol carol 4,0K jun 17 17:29 ..
5388840 -rw-rw-r-- 1 carol carol 2,8M jun 17 15:45 compressed.zip
5388833 -rw-r--r-- 4 carol carol 77K jun 17 17:25 document.txt
5388837 -rw-rw-r-- 1 carol carol 216K jun 17 17:25 image.png
5388833 -rw-r--r-- 4 carol carol 77K jun 17 17:25 text.txt
```
</details>
<br>



---
### Практические задания
1. В каталоге **/usr/share/doc/vim-common/** находится каталог с именем **docs**. Какой командой можно создать символическую ссылку на него в текущем каталоге?

1.1 `ln -s` - это команда создания символической ссылки. Поскольку необходимо указать полный путь к файлу, на который устанавливается ссылка, команда имеет следующий вид:

```sh
ln -s /usr/share/doc/vim-common/docs/ vim-docs
```
1.2 Перейдите в каталог vim-docs и просмотрите его содержимое
```sh
cd vim-docs/
ls
```
```console
arabic.txt    filetype.txt    helphelp.txt  insert.txt    os_mac.txt        pi_paren.txt    russian.txt   tips.txt      usr_10.txt  usr_31.txt   version4.txt
autocmd.txt   fold.txt        help.txt      intro.txt     os_mint.txt       pi_spec.txt     scroll.txt    todo.txt      usr_11.txt  usr_32.txt   version5.txt
builtin.txt   ft_ada.txt      howto.txt     map.txt       os_msdos.txt      pi_tar.txt      sign.txt      uganda.txt    usr_12.txt  usr_40.txt   version6.txt
change.txt    ft_context.txt  if_cscop.txt  mbyte.txt     os_os2.txt        pi_vimball.txt  spell.txt     undo.txt      usr_20.txt  usr_41.txt   version7.txt
channel.txt   ft_mp.txt       if_lua.txt    message.txt   os_qnx.txt        pi_zip.txt      sponsor.txt   userfunc.txt  usr_21.txt  usr_42.txt   version8.txt
cmdline.txt   ft_ps1.txt      if_mzsch.txt  mlang.txt     os_risc.txt       popup.txt       starting.txt  usr_01.txt    usr_22.txt  usr_43.txt   version9.txt
debugger.txt  ft_raku.txt     if_ole.txt    motion.txt    os_unix.txt       print.txt       syntax.txt    usr_02.txt    usr_23.txt  usr_44.txt   vi_diff.txt
debug.txt     ft_rust.txt     if_perl.txt   netbeans.txt  os_vms.txt        quickfix.txt    tabpage.txt   usr_03.txt    usr_24.txt  usr_45.txt   vim9class.txt
develop.txt   ft_sql.txt      if_pyth.txt   options.txt   os_win32.txt      quickref.txt    tags          usr_04.txt    usr_25.txt  usr_50.txt   vim9.txt
diff.txt      gui.txt         if_ruby.txt   os_390.txt    pattern.txt       quotes.txt      tagsrch.txt   usr_05.txt    usr_26.txt  usr_51.txt   visual.txt
digraph.txt   gui_w32.txt     if_sniff.txt  os_amiga.txt  pi_getscript.txt  recover.txt     terminal.txt  usr_06.txt    usr_27.txt  usr_52.txt   windows.txt
editing.txt   gui_x11.txt     if_tcl.txt    os_beos.txt   pi_gzip.txt       remote.txt      term.txt      usr_07.txt    usr_28.txt  usr_90.txt   workshop.txt
eval.txt      hangulin.txt    indent.txt    os_dos.txt    pi_logipat.txt    repeat.txt      testing.txt   usr_08.txt    usr_29.txt  usr_toc.txt
farsi.txt     hebrew.txt      index.txt     os_haiku.txt  pi_netrw.txt      rileft.txt      textprop.txt  usr_09.txt    usr_30.txt  various.txt
```

---
2. Представьте, что в каталоге **~/Documents** имеется файл **clients.txt**, содержащий имена клиентов, и каталог **somedir**. Внутри него находится другой файл с именем **clients.txt** и другими именами. 

2.1 Чтобы воспроизвести эту структуру, выполните следующие команды.

```sh
cd ~/Documents
echo "John, Michael, Bob" > clients.txt
mkdir somedir
echo "Bill, Luke, Karl" > somedir/clients.txt
```

2.2 Затем создайте ссылку внутри **somedir** с именем **partners.txt**, указывающая на этот файл, с помощью команд:

```sh
cd somedir/
ln -s clients.txt partners.txt
```

2.3 Итак, проверьте структуру каталогов:
```sh
tree ~/Documents
```
```console
Documents
|-- clients.txt
`-- somedir
|-- clients.txt
`-- partners.txt -> clients.txt
```

2.4 Теперь переместите файл **partners.txt** из папки **somedir** в папку **~/Documents** и просмотрите его содержимое.

```sh
cd ~/Documents/
mv somedir/partners.txt .
less partners.txt
```

Ссылка по-прежнему работает.
Когда ссылка была перемещена из **~/Documents/somedir** в **~/Documents**, она должна была перестать работать, поскольку цель уже не находилась в том же каталоге, что и ссылка. Однако так получилось, что в каталоге **~/Documents** есть файл с именем **clients.txt**, поэтому ссылка будет указывать на этот файл, а не на исходную цель в каталоге **~/somedir**. Чтобы избежать этого, всегда указывайте полный путь к цели при создании символической ссылки.


---
3. Представьте, что в каталоге создан файл **recipes.txt**. В этом же каталоге создается жесткая ссылка на этот файл, называемая **receitas.txt**, и символическая (или мягкая) ссылка на него, называемая **rezepte.txt**.
```sh
touch recipes.txt
ln recipes.txt receitas.txt
ln -s receitas.txt rezepte.txt
```

3.1 Содержимое каталога должно выглядеть следующим образом:
```sh
ls -lhi

total 160K
5388833 -rw-r--r-- 4 carol carol 77K jun 17 17:25 receitas.txt
5388833 -rw-r--r-- 4 carol carol 0K jun 17 17:25 recipes.txt
5388837 lrwxrwxrwx 1 carol carol 12 jun 17 17:25 rezepte.txt -> receitas.txt
```
Помните, что **receitas.txt**, являясь жесткой ссылкой, указывает на тот же inode, что и **recipes.txt**.

3.2 Удалите файл **receitas.txt** и проверьте Содержимое каталога.

Мягкая ссылка **rezepte.txt** перестанет работать. Это связано с тем, что программные ссылки указывают на имена, а не на inode, и имя **receitas.txt** больше не существует, даже если данные все еще находятся на диске под именем **recipes.txt**.
