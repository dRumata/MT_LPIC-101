## Практическая работа 3. 
## Базовое управление файлами.

> Соответствие LPI101: (103.3 Perform basic file management)

### Вопросы для самопроверки
1. Рассмотрим приведенный ниже список:
```sh
$ ls -lh
total 60K
drwxr-xr-x 2 frank frank 4.0K Apr 1 2018 Desktop
drwxr-xr-x 2 frank frank 4.0K Apr 1 2018 Documents
drwxr-xr-x 2 frank frank 4.0K Apr 1 2018 Downloads
-rw-r--r-- 1 frank frank 21 Sep 7 12:59 emp_name
-rw-r--r-- 1 frank frank 20 Sep 7 13:03 emp_salary
-rw-r--r-- 1 frank frank 8.8K Apr 1 2018 examples.desktop
-rw-r--r-- 1 frank frank 10 Sep 1 2018 file1
-rw-r--r-- 1 frank frank 10 Sep 1 2018 file2
drwxr-xr-x 2 frank frank 4.0K Apr 1 2018 Music
drwxr-xr-x 2 frank frank 4.0K Apr 1 2018 Pictures
drwxr-xr-x 2 frank frank 4.0K Apr 1 2018 Public
drwxr-xr-x 2 frank frank 4.0K Apr 1 2018 Templates
drwxr-xr-x 2 frank frank 4.0K Apr 1 2018 Videos
```
- Что представляет собой символ `d` в выходных данных?
    <details>
    <summary>Вариант ответа</summary>

    `d` - это символ, идентифицирующий каталог.
    
    </details>
<br> 


- Почему размеры приводятся в человекочитаемом формате?
    <details>
    <summary>Вариант ответа</summary>

    Из-за опции `-h`.
    
    </details>
<br> 


- Что изменится в выводе, если использовать `ls` без аргумента?
    <details>
    <summary>Вариант ответа</summary>

    Будут представлены только имена каталогов и файлов.
    
    </details>
<br> 


2. Рассмотрим приведенную ниже команду:
    ```sh
    $ cp /home/frank/emp_name /home/frank/backup
    ```
- Что произойдет с файлом **emp_name** при успешном выполнении этой команды?
    <details>
    <summary>Вариант ответа</summary>

    **emp_name** будет скопирован в резервную копию.
    
    </details>
<br> 


- Если бы **emp_name** был каталогом, какой параметр следует добавить в команду `cp` для ее выполнения?
    <details>
    <summary>Вариант ответа</summary>

    параметр `-r`
    
    </details>
<br> 


- Если теперь команду cp заменить на команду mv, то каких результатов вы ожидаете?
    <details>
    <summary>Вариант ответа</summary>

    emp_name будет перемещен в резервную копию. Он больше не будет присутствовать в домашнем каталоге пользователя frank.
    
    </details>
<br> 


3. Рассмотрим листинг:
    ```sh
    $ ls
    file1.txt file2.txt file3.txt file4.txt
    ```
    Какой подстановочный знак поможет удалить все содержимое этого каталога?
    <details>
    <summary>Вариант ответа</summary>

    Звездочка `*`.
    
    </details>
<br> 


4. Исходя из предыдущего листинга, какие файлы будут отображены следующей командой?

    ```sh
    $ ls file*.txt
    ```
    <details>
    <summary>Вариант ответа</summary>

    Все, поскольку символ "звездочка" обозначает любое количество символов.
    
    </details>
<br> 


5. Дополните команду, добавив в квадратные скобки соответствующие цифры и символы, которые бы перечисляли все содержимое, приведенное выше:
    ```sh
    $ ls file[].txt
    ```
    <details>
    <summary>Вариант ответа</summary>

    Необходимо ввести `file[0-9].txt`
    
    </details>
<br>     


6. Каталог **/home/lpi/databases** содержит множество файлов, в том числе: **db-1.tar.gz**, **db-2.tar.gz** и **db-3.tar.gz**. Какую команду можно использовать, чтобы перечислить только упомянутые файлы?

    <details>
    <summary>Вариант ответа</summary>

    ```sh
    ls db-[1-3].tar.gz
    ```
    
    </details>
<br> 




7.   Рассмотрим следующее перечисление:
```sh
$ find /home/frank/Documents/ -type d
/home/frank/Documents/
/home/frank/Documents/animal
/home/frank/Documents/animal/domestic
/home/frank/Documents/animal/wild
```

- Какие файлы выведет эта команда?
    <details>
    <summary>Вариант ответа</summary>

    Каталоги.
    
    </details>
<br> 


- В каком каталоге начинается поиск?
    <details>
    <summary>Вариант ответа</summary>

    **/home/frank/Documents**
    
    </details>
<br> 


8. Пользователь хочет сжать свою папку резервного копирования. Для этого он использует следующую команду:
    ```sh
    $ tar cvf /home/frank/backup.tar.gz /home/frank/dir1
    ```
    Какой опции не хватает для сжатия резервной копии с помощью алгоритма gzip?
    <details>
    <summary>Вариант ответа</summary>

    Опция `-z`.
    
    </details>
<br> 



---
### Практические задания

1. Используйте globbing-символ
   
1.1   Создайте три пустых файлы
```sh
touch cne1222223.pdf cne12349.txt cne1234.pdf
```
1.2 Удалите только pdf-файлы, используя один globbing-символ:
```sh
rm *.pdf
```

---
2. Перемещение файлов

2.1 В домашнем каталоге создайте файлы с именами **dog** и **cat**.
```sh
touch dog cat
```

2.2 По-прежнему в домашнем каталоге создайте каталог **animal**. Переместите в него **dog** и **cat**.
```sh
mkdir animal
mv dog cat -t animal/
```

2.3 Перейдите в папку **Documents**, находящуюся в домашнем каталоге, и внутри нее создайте резервную копию каталога.
```sh
cd ~/Documents
mkdir backup
```

2.4 Скопируйте каталог **animal** и его содержимое в резервную копию.
```sh
cp -r animal ~/Documents/backup
```

2.5  Переименуйте каталог **animal** в каталоге **backup** в **animal.bkup**.
```sh
mv animal/ animal.bkup
```

---
3.  От вас, как от системного администратора, требуется регулярная проверка с целью удаления объемных файлов. Эти объемные файлы располагаются в каталоге **/var** и имеют расширение **.backup**.

3.1 Запишите команду с помощью `find` для поиска этих файлов:
```sh
find /var -name "*.backup"
```

3.2 Анализ размеров этих файлов показывает, что они находятся в диапазоне от 100 до 1000MB 
```sh
sudo find /var -name "*.backup"|xargs ls -l
```  

3.3 Дополните предыдущую команду этой новой информацией, чтобы найти файлы резервных копий размером от 100 до 1000MB:

```sh
find /var -name "*.backup" -size +100M -size -1000M
```

3.4 Наконец, завершите эту команду действием `delete`, чтобы эти файлы были удалены:
```sh
find /var -name "*.backup" -size +100M -size -1000M -delete
```

---
4.  В каталоге **/var** существует четыре файла резервных копий:
db-jan-2018.backup
db-feb-2018.backup
db-march-2018.backup
db-apr-2018.backup

4.1 Используя `tar`, создайте архивный файл с именем **db-firstquarter-2018.backup.tar**:
```sh
tar -cvf db-first-quarter-2018.backup.tar db-jan-2018.backup db-feb-2018.backup db-march-2018.backup db-apr-2018.backup
```

4.2 Используя `tar`, создайте архив и сожмете его с помощью gzip. Обратите внимание, что имя результирующего файла должно оканчиваться на **.gz**:
```sh
tar -zcvf db-first-quarter-2018.backup.tar.gz db-jan-2018.backup db-feb-2018.backup db-march-2018.backup db-apr-2018.backup
```