## Практическая работа 7. 
## Управление пакетами с помощью RPM и DNF(YUM).

> Соответствие LPI101: (102.5 Use RPM and YUM package management)

### Вопросы для самопроверки

1. Как с помощью `zypper` отключить репозиторий с названием **repo-extras**? 
    <details>
    <summary>Вариант ответа</summary>

    Для изменения параметров репозитория используйте операцию `modifyrepo`, а для его отключения - параметр `-d`: 
    ```sh
    zypper modifyrepo -d repo-extras
    ```
    
    </details>
<br> 


2. Если у вас есть файл **.repo**, описывающий новый репозиторий, куда его следует поместить, чтобы он был распознан `dnf`? 
    <details>
    <summary>Вариант ответа</summary>

    Файлы **.repo** для DNF следует поместить в то же место, которое используется YUM, внутри **/etc/yum.repos.d/**.
    
    </details>
<br> 

3. Как с помощью `zypper` выяснить, какому пакету принадлежит файл **/usr/sbin/swapon**? 
    <details>
    <summary>Вариант ответа</summary>

    Используйте оператор `se` (`search`) и параметр `--provides`: 

    ```sh
    zypper se --provides /usr/sbin/swapon
    ```
    
    </details>
<br> 

4.  Как с помощью `zypper` проверить, установлен ли пакет **unzip**? 
    <details>
    <summary>Вариант ответа</summary>

    Необходимо выполнить поиск (`se`) по установленным (`-i`) пакетам: 

    ```sh
    zypper se -i unzip
    ```
    
    </details>
<br> 

5. 8. Какой командой с помощью `dnf` можно добавить в систему репозиторий, расположенный по адресу https://www.example.url/home:reponame.repo? 

    <details>
    <summary>Вариант ответа</summary>

    Работа с репозиториями - это "изменение конфигурации", поэтому используйте `config-manager` и параметр `--add_repo`: 

    ```sh
    dnf config-manager --add_repo https://www.example.url/home:reponame.repo
    ```
    
    </details>
<br> 


### Практические задания

1. Используя `rpm` в системе Red Hat Enterprise Linux, как установить пакет **VSCodium**, показывая индикатор хода установки? 

1.1 Скачайте пакет по ссылке с помощью `wget` со страницы https://github.com/VSCodium/vscodium/releases (возможно версия пакета могла измениться)
```sh
wget https://github.com/VSCodium/vscodium/releases/download/1.97.2.25045/codium-1.97.2.25045-el9.x86_64.rpm
```

1.2 Используйте параметр -i для установки пакета и параметр -h для включения "хэш-знаков", показывающих ход установки. 
```sh
rpm -ihv codium-1.97.2.25045-el9.x86_64.rpm
```

сравните с результатом:
```console
Verifying...                          ################################# [100%]
Preparing...                          ################################# [100%]
Updating / installing...
   1:codium-1.81.1.23222-el7          ################################# [100%]
```

---
2. Используя `rpm`, выясните, в каком пакете содержится файл **/etc/redhat-release**. 

2.1 Запросите информацию о файле, используйте параметр `-qf`: 
```sh
rpm -qf /etc/redhat-release
```

сравните с результатом:
```console
fedora-release-common-38-36.noarch
```

---
3. C помощью `dnf` проверьте наличие обновлений для всех пакетов в системе.

3.1 Используйте операцию `check-update` без указания имени пакета: 
```sh
dnf check-update
```

3.2 Обновите все пакеты
```sh
dnf update
```
 На запрос продолжения обновления ответьте "y"
 ```console
 Transaction Summary
========================================================================================================================================
Install   7 Packages
Upgrade  70 Packages
Remove    5 Packages

Total download size: 310 M
Is this ok [y/N]: y
Downloading Packages:
[MIRROR] firefox-langpacks-116.0.3-1.fc38_117.0-1.fc38.x86_64.drpm: Status code: 404 for http://mirror.yandex.ru/fedora/linux/updates/38/Everything/x86_64/drpms/firefox-langpacks-116.0.3-1.fc38_117.0-1.fc38.x86_64.drpm (IP: 213.180.204.183)
(1/77): libsoup3-3.4.2-2.fc38_3.4.2-4.fc38.x86_64.drpm                                                  834 kB/s |  54 kB     00:00
(2/77): m17n-lib-1.8.3-1.fc38_1.8.4-1.fc38.x86_64.drpm                                                  374 kB/s |  26 kB     00:00
[MIRROR] firefox-langpacks-116.0.3-1.fc38_117.0-1.fc38.x86_64.drpm: Status code: 404 for https://mirror.yandex.ru/fedora/linux/updates/38/Everything/x86_64/drpms/firefox-langpacks-116.0.3-1.fc38_117.0-1.fc38.x86_64.drpm (IP: 213.180.204.183)
(3/77): kernel-6.4.12-200.fc38.x86_64.rpm                                                               5.0 MB/s | 141 kB     00:00
(4/77): liblerc-4.0.0-3.fc38.x86_64.rpm                  
 ```

---
4. C помощью `dnf` получите список всех установленных в системе пакетов. 

    4.1. Используйте оператор `list`, за которым следует параметр `--installed`: 

    ```sh
    dnf list --installed
    ```

    4.2. Выберите все пакеты, содержащие в имени символы "cod"

    ```sh
    dnf list --installed|grep cod
    ```

Обратите внимание на пакет **codium**. Из какого репозитория он установле в отличии от других пакетов?

```sh
adobe-source-code-pro-fonts.noarch                   2.042.1.062.1.026-2.fc38           @updates
anthy-unicode.x86_64                                 1.0.0.20211224-9.fc38              @fedora
codec2.x86_64                                        1.0.5-2.fc38                       @fedora
codium.x86_64                                        1.81.1.23222-el7                   @@System
dmidecode.x86_64                                     1:3.4-3.fc38                       @fedora
iso-codes.noarch                                     4.13.0-1.fc38                      @fedora
```

---
5. С помощью `yum` выясните, какой пакет предоставляет файл **/bin/wget**. 

5.1 Чтобы узнать, какой пакет предоставляет файл, используйте директиву `whatprovides` и имя файла: 

```sh
yum whatprovides /bin/wget
```

5.2 Повторите тоже самое для файла /etc/ssh/ssh_host_ecdsa_key.pub
```sh
dnf whatprovides /etc/ssh/ssh_host_ecdsa_key.pub
```
**Обратите внимание:** если вы используете дистрибутив RHEL9 или Fedora41, то там используется **dnf5**
В dnf5 (который является более новой версией dnf, используемой в системах на основе RHEL, таких как Fedora, CentOS, RHEL 9 и т. д.), команда dnf whatprovides была заменена на новую команду, которая выполняет ту же функцию, но с изменённым синтаксисом `dnf provides`.

5.3 Уточните у инструктора/преподавателя почему файл есть, а связи с пакетом нет.
