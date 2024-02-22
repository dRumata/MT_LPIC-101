## Практическая работа 2. 
## Установка загрузчика.

> Соответствие LPI101: (102.2 Install a boot manager).

### Вопросы для самопроверки

1. В каком месте по умолчанию находится файл конфигурации **GRUB 2**? 
    <details>
    <summary>Вариант ответа</summary>

    ```c
    /boot/grub/grub.cfg
    ```
    
    </details>
<br> 


2. В какой файл следует добавить пункты пользовательского меню **GRUB 2**? 

    <details>
    <summary>Вариант ответа</summary>

    **/etc/grub.d/40_custom**
    
    </details>
<br> 


3. Где хранятся пункты меню **GRUB Legacy**? 

    <details>
    <summary>Вариант ответа</summary>

    **/boot/grub/menu.lst**
    
    </details>
<br> 


4. Как вы можете войти в командную консоль **GRUB** в меню **GRUB 2** или **GRUB Legacy**? 

    <details>
    <summary>Вариант ответа</summary>

    Нажмите **`c`** на экране меню.
    
    </details>
<br> 


5. Представьте, что пользователь настраивает **GRUB Legacy** для загрузки со второго раздела первого диска. Он пишет следующую запись пользовательского меню: 
    ```c
    title My Linux Distro
    root (hd0,2)
    kernel /vmlinuz root=/dev/hda1
    initrd /initrd.img
    ```
    Однако система не загружается. Что не так? 

    <details>
    <summary>Вариант ответа</summary>

    Загрузочный раздел неправильный. Помните, что, в отличие от GRUB 2, GRUB Legacy считает разделы с нуля. Таким образом, правильная команда для второго раздела первого диска должна быть **root (hd0,1)**.
    
    </details>
<br> 

6. Какие команды из оболочки **GRUB Legacy** необходимы для установки **GRUB** на первый раздел второго диска?

    <details>
    <summary>Вариант ответа</summary>

    ```c
    grub> root (hd1,0)
    grub> setup (hd1)
    ```
    
    </details>
<br> 


### Практические задания

1.  Настройте **GRUB 2** на ожидание 10 секунд перед загрузкой пункта меню по умолчанию? 

1.1 Добавьте параметр или исправьте уже заданное значение `GRUB_TIMEOUT=10` в **/etc/default/grub**.
```sh
[student@fedora ~]$ cat /etc/default/grub
GRUB_TIMEOUT=10
GRUB_DISTRIBUTOR="$(sed 's, release .*$,,g' /etc/system-release)"
GRUB_DEFAULT=saved
GRUB_DISABLE_SUBMENU=true
GRUB_TERMINAL_OUTPUT="console"
GRUB_CMDLINE_LINUX="rd.lvm.lv=fedora_fedora/root rhgb quiet"
GRUB_DISABLE_RECOVERY="true"
GRUB_ENABLE_BLSCFG=true
```

1.2 Затем обновите конфигурацию с помощью команды 
```sh
sudo grub2-mkconfig -o /boot/grub2/grub.cfg
```

1.3 Перезагрузите сервер и проверьте, что обратный отсчет загрузчика начинается с 10 секунд. 

---
2. Произведите поиск **UUID** раздела **/dev/sda2** и убедитесь, что он соответствует разделу, монтируему в каталог **/boot**

2.1 Используйте команду
```sh
ls -la /dev/disk/by-uuid/ 
```
и найдите UUID, который указывает на раздел /dev/sda2. Запомните или запишите эти данные.

2.2 Используйте команду
```sh
lsblk -f 
```
и найдите UUID, который указывает на раздел /dev/sda2. Запомните или запишите эти данные.

2.3 Просмотрите содержимое файла /etc/fstab командой `cat`
```sh
[student@fedora ~]$ cat /etc/fstab

#
# /etc/fstab
# Created by anaconda on Thu Aug 24 13:43:13 2023
#
# Accessible filesystems, by reference, are maintained under '/dev/disk/'.
# See man pages fstab(5), findfs(8), mount(8) and/or blkid(8) for more info.
#
# After editing this file, run 'systemctl daemon-reload' to update systemd
# units generated from this file.
#
/dev/mapper/fedora_fedora-root /                       xfs     defaults        0 0
UUID=6b889288-6ed5-4b71-9b51-f0e8842dec10 /boot                   xfs     defaults        0 0
```
Сверьте ранее полученые значения для /dev/sda2 и строку содержащую указание на точку монтирования **/boot**. Они должны совпадать.

3.  Добавьте дополнительный пункт меню загрузки. Рассмотрим следующую запись для меню **GRUB 2** 
    ```ini
    menuentry "Default OS" {
    set root=(hd0,1)
    linux /vmlinuz root=/dev/sda1 ro quiet splash
    initrd /initrd.img
    }
    ```
3.1 Измените его так, чтобы система загружалась с диска с **UUID** полученного в предыдущем задании (2). Вместо того, чтобы указывать диск и раздел, скажите grub искать раздел с нужным **UUID**. Исправьте файл  **/etc/grub.d/40_custom** как в примере ниже. Имена файлов **vmlinuz** и **initramfs** уточните в листинге каталога **/boot**
```ini
[student@fedora ~]$ sudo cat /etc/grub.d/40_custom
#!/usr/bin/sh
exec tail -n +3 $0
# This file provides an easy way to add custom menu entries.  Simply type the
# menu entries you want to add after this comment.  Be careful not to change
# the 'exec tail' line above.

menuentry "Default OS" {

search --set=root --fs-uuid 6b889288-6ed5-4b71-9b51-f0e8842dec10
linux /vmlinuz-6.4.11-200.fc38.x86_64 root=/dev/mapper/fedora_fedora-root ro quiet splash
initrd /initramfs-6.4.11-200.fc38.x86_64.img
}
```

3.2 Затем обновите конфигурацию с помощью команды 
```sh
sudo grub2-mkconfig -o /boot/grub2/grub.cfg
```

3.3 Перезагрузите систему и выберите строку "Default OS" - если все сделано правильно, система должна загрузиться.
