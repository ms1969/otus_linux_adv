## Домашние задания OTUS Linux advanced

## Lesson 2

<details>
Сделанные задания:

1. Изменен Vagrantfile. Файл находиться в папке lesson2.
2. Создан RAID10 и файл mdadm.conf. Ход выполнения отражен в файле lesson2/screen1.
3. Разрушен и восстановлен RAID. Создана и смонтирована файловая система. Изменен файл fstab. Ход работ в файле lesson2/screen2.
4. На RAID созданы разделы GPT. Ход работ в файле lesson2/screen3

приложения в папке lesson2: Vagrantfile, mdadm.conf, mdraid.sh, fstab
  
  </details>

## Lesson 3 & 4 (LVM)

<details>
Сделанные задания:

1. Уменьшен том под / до 8G
2. Выделен том под /var (/var - сделан в mirror). прописано монтирование в fstab
3. Выделен том под /home (прописано монтирование в fstab)
4. Для /home - сделан том для снэпшотов.
5. Работа со снапшотами: сгенерированы файлы в /home/, снят снэпшот, удалена часть файлов, выполненно востановление файлов со снэпшота

   Материалы с коментариями находятся в папке lesson3:
                                         Vagrantfile,
                                         part1.txt (Уменьшение тома до 8G),
                                         part2.txt, (Продолжение) 
                                         part3.txt, (Создание тома с зеркалом /var)
                                         part4.txt. (Работа с томом /home)
   </details>
   
## Lesson 5 (ZFS)

<details>

Задания:
  
1. Определить алгоритм с наилучшим сжатием

2. Определить настройки пула.

3. Работа со снапшотами.

4. Создание отдельного Bash-скрипт и добавить его в Vagrantfile для подготовки сервера ZFS.

  Материалы с комментариями находятся в папке lesson5:
  
        1. Ход выполнения первого задания (screen1.txt)
        
        2. Ход выполнения второго задания (screen2.txt)
        
        3. Ход выполнения третьего задания (screen3.txt)
        
        4. Для выполнения четвертого задания создан скрипт prepare.sh, 
               запуск скрипта осуществляется с помощью директивы Vagrantfile (файлы: prepare.sh, Vagrantfile прилагаются).

</details>

## Lesson 6 (NFS)

<details>

Задания:
- `vagrant up` должен поднимать 2 настроенных виртуальных машины
(сервер NFS и клиента) без дополнительных ручных действий;
- на сервере NFS должна быть подготовлена и экспортирована
директория;
- в экспортированной директории должна быть поддиректория
с именем __upload__ с правами на запись в неё;
- экспортированная директория должна автоматически монтироваться
на клиенте при старте;
- монтирование и работа NFS на клиенте должна быть организована
с использованием NFSv3 по протоколу UDP;
- firewall должен быть включен и настроен как на клиенте,
так и на сервере.

1. Создан Vagrantfile для создания машины сервера и клиента,
   к Vagrantfile подключены 2 скрипта (серверный - nfss_setup.sh и клиентский nfsc_setup.sh) для автоматизации выполнения задания.
2. Выполнена проверка выполнения требований задания до и после перезакгрузки клиента и сервера.
3. Ход выполнения работ с комментариями отражен в файлах экрана (server.txt - для сервера и client.txt - для клиента)

Материалы размещены в папке lesson6.


</details>

## Lesson 7 (RPM)

<details>

Задания:

1) Создать свой RPM пакет c дополнительными опциями (В нашем случае NGINX c openssl)
2) Создать свой репозиторий и разместить там ранее собранный RPM

Выполнение:
1. Создан Vagrantfile для создания машины.
2. При старте выполняется provision с использованием скрипта setup_script.sh для установки необходимых пакетов.
3. Создан свой пакет nginx с опцией openssl.
4. Создан собственный репозиторий otus-linux.
5. В репозиторий дополнительно к ngnix размещен пакет mysql.
6. Проведено тестирование работосаособности репозитория.

Ход выполнения работ с коментариями находится в terminal.txt
  
Материалы размещены в папке lesson7: 

Vagrantfile, 

setup_script.sh - скрипт первоначальной установки пакетов;

nginx.spec - файл конфигурирования пакета с добавленой опцией openssl;

terminal.txt - файл хода работ с коментариями и выводом консоли.

</details>

## Lesson8 - Загрузка системы

<details>

#### Задание:


1.Сбросить пароль пользователя root 3-мя способами 

2.Переименовть VG с корневым томом  

3.Добавить модуль в initrd  

#### 1.Сбросить пароль root 

При загрузке системы нажимаем **e**, для получения доступа к меню загрузчика, на скриншотах ниже приведены 3 различных варианта изменений в загрузчике.
Параметр **rw**монтирует раздел /root в режиме read-write.
Файл /**.autorelabel**  подтверждает легитимность внесения изменений в /etc/shadow для selinux.
**mount -o remount,ro / -** проводит перемонтирование в режиме read-only.

Первый способ: меняем параметр *ro* на *rw* указываем параметр init=/bin/sh

![Image 1](lesson8/method1-screen1.png)

Меняем успешно пароль root

![Image 2](lesson8/method1-screen2.png)

Устанавливает параметр rd.break в режиме **ro**

![Image 3](lesson8/method2-screen1.png)

Перемонтируем файловую систему в режие **rw**

Меняем / командой chroot

Файл /.autorelabel  подтверждает легитимность внесения изменений в /etc/shadow

Меняем успешно пароль root

![Image 4](lesson8/method2-screen2.png)

Устанавливаем параметр init=/sysroot/bin/sh, меняем режим на *rw*

![Image 5](lesson8/method3-screen1.png)

Меняем успешно пароль root

![Image 6](lesson8/method3-screen2.png)


#### 2.Установить систему с LVM, после чего переименовать VG

Проверяем текущее состояние системы и выполняем переименование volume group в OtusRoot

![Image 7](lesson8/vgs_begin.png)

Выполняем корректировку название VG в файлах:

a) /etc/fstab

![Image 8](lesson8/fstab.png)

b) /etc/default/grub

![Image 9](lesson8/grub.png)

c) /boot/grub2/grub.cfg

![Image 10](lesson8/grub_cfg.png)




</details>



