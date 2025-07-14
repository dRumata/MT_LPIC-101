## Практическая работа 16
.
## Управление подключением и отключением файловых систем.

> Соответствие LPI101: (104.3 Control mounting and unmounting of filesystems)

### Вопросы для самопроверки

1. Как с помощью `mount` можно смонтировать файловую систему ext4 на **/dev/sdc1** в каталог **/mnt/external** как только для чтения, используя опции `noatime` и async`?

    <details>
    <summary>Вариант ответа</summary>

    ```sh
    mount -t ext4 -o noatime,async,ro /dev/sdc1 /mnt/external
    ````
    
    </details>
<br>    


2. При размонтировании файловой системы на **/dev/sdd2** выдается сообщение об ошибке target is busy. Как узнать, какие файлы на файловой системе открыты и какие процессы их открывали?

    <details>
    <summary>Вариант ответа</summary>

    Используйте команду `lsof` с последующим указанием имени устройства:
    ```sh
    lsof /dev/sdd2
    ```
    
    </details>
<br> 
   


3. Рассмотрим следующую запись в файле **/etc/fstab**: 
`/dev/sdb1 /data ext4 noatime,noauto,async`

Будет ли смонтирована эта файловая система при выполнении команды `mount -a`? Почему?

<details>
<summary>Вариант ответа</summary>

    Она не будет смонтирована. Ключевым является параметр `noauto`, который означает, что эта запись будет проигнорирована командой `mount -a`.
    
</details>
<br> 


4. Как узнать UUID файловой системы на раздкле **/dev/sdb1**?
<details>
    <summary>Вариант ответа</summary>

Используйте `lsblk -f`, а затем имя файловой системы:
```sh
lsblk -f /dev/sdb1
```
    
</details>
<br> 


5. Как с помощью `mount` перемонтировать в режим "только чтение" файловую систему **exFAT** с **UUID 6e2c12e3-472d-4bac-a257-c49ac07f3761**, смонтированную по адресу **/mnt/data**?
<details>
    <summary>Вариант ответа</summary>

Так как файловая система смонтирована, вам не нужно беспокоиться о типе файловой системы или ее идентификаторе, достаточно использовать опцию `remount` с параметром `ro` (только для чтения) и точкой монтирования:
```sh
mount -o remount,ro /mnt/data
```
    
</details>
<br> 


6. Как получить список всех файловых систем ext3 и ntfs, смонтированных в данный момент в системе?
<details>
    <summary>Вариант ответа</summary>

Используйте команду `mount -t`, за которой следует список файловых систем, разделенный запятыми:
```sh
mount -t ext3,ntfs
```
    
</details>
<br> 


7. Рассмотрим следующую запись в **/etc/fstab**: 
```console
/dev/sdc1 /backup ext4 noatime,nouser,async
```
Может ли пользователь подключить эту файловую систему с помощью команды `mount /backup`? Почему?
<details>
    <summary>Вариант ответа</summary>

Нет, параметр `nouser` не позволит обычным пользователям монтировать эту файловую систему.
    
</details>
<br> 



8. Рассмотрим удаленную файловую систему, смонтированную по адресу **/mnt/server**, которая стала недоступной из-за потери сетевого соединения. Как можно принудительно размонтировать ее или смонтировать как **readonly** если это невозможно?
<details>
    <summary>Вариант ответа</summary>

Передайте параметры `-f` и `-r` для размонтирования. Команда будет выглядеть так: `umount -f -r /mnt/server`. Помните, что параметры можно группировать, поэтому `umount -fr /mnt/server` также будет работать.
    
</details>
<br>    


9.  Рассмотрим следующий юнит монтирования systemd:
```ini
[Unit]
Description=External data disk

[Mount]
What=/dev/disk/by-uuid/56C11DCC5D2E1334
Where=/mnt/external
Type=ntfs
Options=defaults

[Install]
WantedBy=multi-user.target
```

- Какой будет эквивалентная запись **/etc/fstab** для этой файловой системы?
<details>
    <summary>Вариант ответа</summary>

Запись будет такой: 
```console
UUID=56C11DCC5D2E1334 /mnt/external ntfs defaults
```
    
</details>
<br>    

- Каким должно быть имя файла для вышеуказанного юнита, чтобы он мог использоваться **systemd**? Где он должен быть размещен?
<details>
    <summary>Вариант ответа</summary>

Имя файла должно совпадать с именем точки монтирования, поэтому **mnt-external.mount**, размещенный в файле **/etc/systemd/system**.
    
</details>
<br>  



---
### Практические задания
Создание и монтирование файловой системы

1. Отформатируйте раздел **/dev/sdb1/** в файловой системе **XFS**.
```bash
sudo mkfs.xfs /dev/sdb1
```

2. Проверьте информацию о разделе **sdb1** с помощью комманды `lsblk`. 

3. Отформатируете раздел **/dev/sdb2/** в файловой системе **ext4**.
```bash
sudo mkfs.ext4 /dev/sdb2  -L LAB162
```

4. Проверьте информацию о разделе **sdb2** с помощью комманды `lsblk -f`. Что значит ключ `-L` использованный в предыдущем шаге?
   
5. Используйте `tune2fs -o`, чтобы установить параметры монтирования файловой системы по умолчанию. Используйте `tune2fs` для включения списков управления доступом и расширенных пользователем атрибутов.

```bash
tune2fs -o acl,user_xattr /dev/sdb2
```

6. Измените некоторые свойства **XFS** с помощью команды `xfs_admin`, установите для метки файловой системы значение **LAB161**.
```bash
xfs_admin -L LAB161 /dev/sdb1
```

7. Создание раздела подкачки. Используйте `gdisk`.
```bash
gdisk /dev/sdb
```

8. Введите `t`, чтобы изменить тип раздела. Если вы используете `fdisk`, используйте тип раздела **82**. Если вы используете `gdisk`, используйте тип раздела **8200**.
```console
GPT fdisk (gdisk) version 1.0.9

Partition table scan:
  MBR: protective
  BSD: not present
  APM: not present
  GPT: present

Found valid GPT with protective MBR; using GPT.

Command (? for help): p
Disk /dev/sdb: 10485760 sectors, 5.0 GiB
Model: Virtual disk
Sector size (logical/physical): 512/512 bytes
Disk identifier (GUID): CDDB5967-DA92-45EE-A0D7-11C78784EBAE
Partition table holds up to 128 entries
Main partition table begins at sector 2 and ends at sector 33
First usable sector is 34, last usable sector is 10485726
Partitions will be aligned on 2048-sector boundaries
Total free space is 1408957 sectors (688.0 MiB)

Number  Start (sector)    End (sector)  Size       Code  Name
   1            2048         2099199   1024.0 MiB  8300  Linux filesystem
   2         2099200         5171199   1.5 GiB     8300  Linux filesystem
   3         5171200         9078783   1.9 GiB     8300  part3

Command (? for help): ?
b	back up GPT data to a file
c	change a partition's name
d	delete a partition
i	show detailed information on a partition
l	list known partition types
n	add a new partition
o	create a new empty GUID partition table (GPT)
p	print the partition table
q	quit without saving changes
r	recovery and transformation options (experts only)
s	sort partitions
t	change a partition's type code
v	verify disk
w	write table to disk and exit
x	extra functionality (experts only)
?	print this menu

Command (? for help): t
Partition number (1-3): 3
Current type is 8300 (Linux filesystem)
Hex code or GUID (L to show codes, Enter = 8300): L
Type search string, or <Enter> to show all codes: swap
8200 Linux swap                          a502 FreeBSD swap
a582 Midnight BSD swap                   a901 NetBSD swap
bf02 Solaris swap
Hex code or GUID (L to show codes, Enter = 8300): 8200
Changed type of partition to 'Linux swap'

Command (? for help):
```

9.  Используйте `mkswap`, чтобы отформатировать раздел как пространство подкачки (**swap**).
```bash
mkswap /dev/sdb3
```

10. Введите `free -mh`. Вы видите объем пространства подкачки, которое в настоящее время выделено. Сюда не входит пространство подкачки, которое вы только что создали, поскольку его еще нужно активировать.
    
11. Используйте `swapon`, чтобы включить недавно выделенное пространство подкачки. 
```bash
swapon /dev/sdb3
```

12. Снова введите `free -mh`. Вы видите, что к вашему серверу добавлено новое пространство подкачки.


13. Просмотрите информацию о разделах **/dev/sdb** с помощью комманды `lsblk -f`.


14. Создайте два каталога **LAB16_sdb1** и **LAB16_sdb2** в `/mnt`
```bash
mkdir /mnt/LAB16_sdb{1,2}
```

15.  Просмотрите и добавьте информацию об **UUID** и **LABEL** для дисков **sdb1** и **sdb2** в файл `/etc/fstab`. Используйте комманды `blkid` и `tee`.
```bash
sudo blkid /dev/sdb1 |sudo tee -a /etc/fstab
sudo blkid /dev/sdb2 |sudo tee -a /etc/fstab
```
Содержимое `/etc/fstab` может иметь похожий вид:
```bash
cat /etc/fstab
```
```console
#
# /etc/fstab
# Created by anaconda on Mon Apr  3 13:25:03 2023
#
# Accessible filesystems, by reference, are maintained under '/dev/disk/'.
# See man pages fstab(5), findfs(8), mount(8) and/or blkid(8) for more info.
#
# After editing this file, run 'systemctl daemon-reload' to update systemd
# units generated from this file.
#
/dev/mapper/fedora-root /                       xfs     defaults        0 0
UUID=888e3dda-e00e-4211-99ca-d22a0e74f844 /boot                   xfs     defaults        0 0
/dev/mapper/fedora-home /home                   xfs     defaults        0 0
/dev/mapper/fedora-srv /srv                    xfs     defaults        0 0
/dev/mapper/fedora-tmp /tmp                    xfs     defaults        0 0
/dev/mapper/fedora-var /var                    xfs     defaults        0 0
/dev/mapper/fedora-swap none                    swap    defaults        0 0
/dev/sdb1: LABEL="LAB161" UUID="f6a6b244-ddb3-46b2-80d1-881c9ebc565d" BLOCK_SIZE="512" TYPE="xfs" PARTLABEL="Linux filesystem" PARTUUID="dcc854bc-dc33-48f6-9597-efe5eb4109a2"
/dev/sdb2: LABEL="LAB162" UUID="2d1ebba0-ceb9-468b-b5dc-2a78330677d8" BLOCK_SIZE="4096" TYPE="ext4" PARTLABEL="Linux filesystem" PARTUUID="fdea8a67-a169-4518-a1f6-b46eba566d54"
```

16.  Исправьте последние две строки в файле `/etc/fstab` В резальтате вы получите примерный вид последних двух строк:
```console
LABEL="LAB161" 				/mnt/LAB16_sdb1	xfs	defaults	0 0
UUID=2d1ebba0-ceb9-468b-b5dc-2a78330677d8 	/mnt/LAB16_sdb2 	ext4	defaults	0 0
```

17.  Проверьте смонтированые диски в системе и их объем.
```bash
df -h
```

18.  Подключите прописанные в `/etc/fstab` новые разделы 
```bash
sudo mount -a
```
Если все сделано правильно, то разделы будут подключены, в противном случае исправьте ошибки о которых вас уведомит система.

19.  Проверьте смонтированые диски в системе и их объем. Сравните с информацией из шага 17. Что изменилось?
```bash
df -h
``` 