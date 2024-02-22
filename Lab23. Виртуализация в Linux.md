## Практическая работа 23. 
## Виртуализация в Linux.

> Соответствие LPI101: (102.6 Linux as a virtualization guest)

### Вопросы для самопроверки

1. Какие расширения процессора необходимы для аппаратной платформы на базе x86, на которой будут работать полностью виртуализированные гости? 

    <details>
    <summary>Вариант ответа</summary>

    VT-x для процессоров Intel или AMD-V для процессоров AMD
    
    </details>
<br> 


2. При установке критически важного сервера, требующего максимальной производительности, скорее всего, будет использоваться какой тип виртуализации? 

    <details>
    <summary>Вариант ответа</summary>

    Операционная система, использующая паравиртуализацию, например Xen, в качестве гостевой операционной системы может более эффективно использовать доступные ей аппаратные ресурсы за счет применения программных драйверов, разработанных для работы с гипервизором.
    
    </details>
<br> 


3. Две виртуальные машины, клонированные из одного шаблона и использующие шину D-Bus, работают нестабильно. Они имеют разные имена хостов и параметры сетевой конфигурации. Какую команду следует использовать для определения того, что каждая из виртуальных машин имеет разные идентификаторы D-Bus Machine ID? 

    <details>
    <summary>Вариант ответа</summary>

    dbus-uuidgen --get
    
    </details>
<br> 




### Практические задания

1.1 Проверьте, включены ли в вашей системе расширения процессора для запуска виртуальной машины (результаты могут отличаться в зависимости от процессора): 

```sh
grep --color -E "vmx|svm" /proc/cpuinfo
```

В зависимости от результатов, у вас может быть выделено "vmx" (для процессоров Intel с поддержкой VT-x) или "svm" (для процессоров AMD с поддержкой SVM). Если результатов нет, обратитесь к инструкциям BIOS или прошивки UEFI, чтобы узнать, как включить виртуализацию для вашего процессора. Результаты будут зависеть от используемого процессора. Ниже приведен пример результатов, полученных на компьютере с процессором Intel с включенными расширениями виртуализации в микропрограмме UEFI:
```console
$ grep --color -E "vmx|svm" /proc/cpuinfo
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36
clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc
art arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni
pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1
sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm
3dnowprefetch cpuid_fault epb invpcid_single pti ssbd ibrs ibpb stibp tpr_shadow vnmi
flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms invpcid rtm
mpx rdseed adx smap clflushopt intel_pt xsaveopt xsavec xgetbv1 xsaves dtherm ida arat
pln pts hwp hwp_notify hwp_act_window hwp_epp md_clear flush_l1d
```
1.2 Подтвердите, что модули KVM загружены в ядро (по умолчанию они должны быть).
```bash
lsmod | grep kvm
```
---
2. Если процессор поддерживает виртуализацию, найдите документацию по запуску гипервизора KVM в своем дистрибутиве. 

Это зависит от дистрибутива, но вот некоторые отправные точки: 
Ubuntu - https://help.ubuntu.com/lts/serverguide/libvirt.html 
Fedora - https://docs.fedoraproject.org/en-US/quick-docs/getting-started-with-virtualization/ 
Arch Linux - https://wiki.archlinux.org/index.php/KVM 

---
3. Установите пакеты, необходимые для работы гипервизора KVM. 

3.1 Найдите и установите группы пакетов для организации сервера виртуализации
```bash
sudo dnf grouplist --hidden --verbose|grep virt
sudo dnf groupinstall virtualization virtualization-headless
```

3.2 Установите другие пакеты виртуализации. Пакет **virt-install** предоставляет инструмент для установки виртуальных машин из интерфейса командной строки, а **virt-viewer** используется для просмотра виртуальных машин.
```bash
dnf install virt-install virt-viewer libvirt
```

3.3 Добавьте пользователя **student**  в группы  **qemu** и **libvirt**
```sh
sudo usermod -aG qemu student
```

3.4 Перезагрузите сервер

3.5 В графическом столе в меню найдите приложение Virtual Machine Manager и запустите его. Убедитесь что смогли подключиться к гипервизору.

---
4. Загрузите ISO-образ дистрибутива Linux и, следуя документации дистрибутива, создайте новую виртуальную машину с помощью этого ISO. 

4.1 Cкачайте дистрибутив AlpineLinux c сайта https://www.alpinelinux.org/downloads/ 
Рекомендуется выбрать **Standard** для своей архитектуры.

4.2 Скопируйте iso в директорию  **/var/lib/libvirt/images/**
```sh
 sudo mv Downloads/alpine-standard-3.18.3-x86_64.iso /var/lib/libvirt/images/ -v
```

4.3 В Virtual Machine Manager нажмите "Создатьновую ВМ", затем выберите "Local Install ISO", далее укажите на добавленый  iso-образ  и соглашаясь с предложениями визарда установите новую вм с ОС AlpineLinux.

4.4 Виртуальную машину можно создать и из командной строки с помощью команды `virt-install`. Попробуйте этот способ, если у вас осталось время запланированное на практику.