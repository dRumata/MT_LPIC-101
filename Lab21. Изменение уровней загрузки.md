## Практическая работа 21. 
## Изменение уровней загрузки, выключение и перезагрузка системы

> Соответствие LPI101: (101.3 Change runlevels / boot targets and shutdown or reboot system)

### Вопросы для самопроверки

1. Как можно использовать команду `telinit` для перезагрузки системы? 

   <details>
   <summary>Вариант ответа</summary>
    Команда 
    ```sh
    telinit 6
    ```
    переводит систему на уровень выполнения 6, то есть перезагружает систему.
    </details>
<br>   


2. Что произойдет с сервисами, связанными с файлом **`/etc/rc1.d/K90network`**, когда система перейдет на уровень выполнения **1**? 

   <details>
   <summary>Вариант ответа</summary>
    Из-за буквы **`K`** в начале имени файла соответствующие службы будут остановлены.
    </details>
<br>     

3. Предположим, что в системе на базе **SysV** уровень выполнения по умолчанию, заданный в файле **`/etc/inittab`**, равен **`3`**, но система всегда запускается с уровнем выполнения **`1`**. Какова вероятная причина этого? 

   <details>
   <summary>Вариант ответа</summary>
    В списке параметров ядра могут присутствовать параметры **`1`** или **`S`**.
    </details>
<br>     

---

### Практические задания

1. Проверьте помощью команды `systemctl`, работает ли юнит **sshd.service**? 
   
1.1. С помощью команды 
```sh
systemctl status sshd.service 
```
1.2. Сравните с результатом команды
```sh
systemctl is-active sshd.service
```

---
2. В системе на базе **systemd** включите активацию юнита **cups.service** при инициализации системы.
   
2.1. Проверьте статуc сервиса **cups.service**
```
systemctl status cups.service
```

```
● cups.service - CUPS Scheduler
     Loaded: loaded (/usr/lib/systemd/system/cups.service; disabled; preset: disabled)
```
Disabled означает, что юнит не стартует при инициализации системы

2.2. Выполните от пользователя root.
```sh
sudo systemctl enable cups.service
```

2.3. Проверьте статуc сервиса повторно. Должно изменится на:
```console
● cups.service - CUPS Scheduler
     Loaded: loaded (/usr/lib/systemd/system/cups.service; enabled; preset: disabled)
```

---
3. Хотя файл **/sbin/init** можно найти в системах на базе **systemd**, он является лишь символической ссылкой на другой исполняемый файл. Узнеайте на какой файл указывает **/sbin/init**? 
   
3.1. Используйте команду
```sh
file /sbin/init
```

3.2. Сравните с командой
```sh
ls -l /sbin/init
```

3.3. В обоих случаях вы должны увидеть указание на `../lib/systemd/systemd`

---
4. Проверьте **system target** по умолчанию в системе на базе **systemd**. 
   
4.1. Посмотрите куда ведет символическая ссылка **/etc/systemd/system/default.target** 
```
file /etc/systemd/system/default.target
```
она будет указывать на файл, определенный как цель по умолчанию. 

4.2. Также используйте команду 
```sh
systemctl get-default
```

4.3. Сравните результаты. Имена таргетов должны совпасть.
Например:
```bash
[student@fedora ~]$ file /etc/systemd/system/default.target
/etc/systemd/system/default.target: symbolic link to /usr/lib/systemd/system/graphical.target
[student@fedora ~]$ systemctl get-default
graphical.target
```

---
5. Отменить перезагрузку системы, запланированную с помощью команды `shutdown`. 

5.1. Прочитайте документацию по команде `shutdown`  и найдите как задать время перезагрузки (обратите внимание, именно перезагрузки)
```sh
man shutdown
```

5.2. Запланируйте перезагрузку на 22:30
```sh
shutdown -r 22:30
```

5.3. Проверьте время перезагрузки
```sh
shutdown --show
```
```sh
[student@fedora ~]$ sudo shutdown --show
Reboot scheduled for Fri 2023-08-25 22:30:00 MSK, use 'shutdown -c' to cancel.
```

5.4. Отмените перезагрузку системы
```sh
shutdown -c
```

5.5. Убедитесь, что перезагрузка отменена
```sh
shutdown --show
```

