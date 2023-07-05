#!/bin/bash

# Считываем номер строки из файла и присваиваем переменной для определения пополнялся ли лог и с какого места начинать считывание файла
number=$(cat ./lnnumber 2>/dev/null);status=$?

# Считаем строки и записываем в переменную значение первого поля, которое считает количество строк.
checkLines=$(wc /root/otus/otus_linux_adv/lesson10/access.log | awk '{print $1}')

# Если возвращается пустое значение, т.е. его нет, тогда считаем количество строк и записываем значение в файл
if ! [ -n "$number" ]
then
    # Дата начала и конца
    # Записываем в переменную значение полей 4 и 5, удалив квадратные скобки, отправив на последний pipe только первую строку.
    StartTime=$(awk '{print $4 $5}' /root/otus/otus_linux_adv/lesson10/access.log  | sed 's/\[//; s/\]//' | sed -n 1p)o
    # Записываем в переменную значение полей 4 и 5, удалив квадратные скобки, отправив на последний pipe только последнюю строку, взятую из переменной checkLines.
    EndTime=$(awk '{print $4 $5}' /root/otus/otus_linux_adv/Lesson10/access.log | sed 's/\[//; s/\]//' | sed -n "$checkLines"p)
    # Записываем  количество строк в файле
    echo $checkLines > ./lnnuber
    # Определение количества IP запросов с IP адресов
    #NR - Встроенная переменная AWK определяющая количество записей
    IP=$(awk "NR>$checkLines"  /root/otus/otus_linux_adv/lesson10/iacccess.log | awk '{print $1}' | sort | uniq -c | sort -rn | awk '{ if ( $1 >= 0 ) { print "Количество запросов:" $1, "IP:" $2 } }')
    # Y количества адресов
    addresses=$(awk '($9 ~ /200/)' /root/otus/otus_linux_adv/lesson10/Lesson10/access.log |awk '{print $7}'|sort|uniq -c|sort -rn|awk '{ if ( $1 >= 10 ) { print "Количество запросов:" $1, "URL:" $2 } }')
    # Ошибки c момента последнего запуска
    errors=$(cat access-4560-644067.log | cut -d '"' -f3 | cut -d ' ' -f2 | sort | uniq -c | sort -rn)
    # Отправка почты
    echo -e "Данные за период:$StartTime-$EndTime\n$IP\n\n"Часто запрашиваемые адреса:"\n$addresses\n\n"Частые ошибки:"\n$errors" | mail -s "check msg" root@localhost
else
    # Дата начала и конца
    StartTime=$(awk '{print $4 $5}' /root/otus/otus_linux_adv/lesson10/access.log | sed 's/\[//; s/\]//' | sed -n "$(($number+1))"p)
    EndTime=$(awk '{print $4 $5}' /root/otus/otus_linux_adv/lesson10/access.log | sed 's/\[//; s/\]//' | sed -n "$checkLines"p)
    # Определение количества IP запросов с IP адресов
    IP=$(awk "NR>$(($number+1))" /root/otus/otus_linux_adv/lesson10/access.log | awk '{print $1}' | sort | uniq -c | sort -rn | awk '{ if ( $1 >= 0 ) { print "Количество запросов:" $1, "IP:" $2 } }')
    # Y количества адресов
    addresses=$(awk '($9 ~ /200/)' /root/otus/otus_linux_adv/lesson10/access.log |awk '{print $7}'|sort|uniq -c|sort -rn|awk '{ if ( $1 >= 10 ) { print "Количество запросов:" $1, "URL:" $2 } }')
    # Ошибки c момента последнего запуска
    errors=$(cat /root/otus/otus_linux_adv/lesson10/access.log | cut -d '"' -f3 | cut -d ' ' -f2 | sort | uniq -c | sort -rn)
    # Записываем количество строк в файле
    echo $checkLines > ./lnnumber
    # Отправка почты
    echo -e "Данные за период:$StartTime-$EndTime\n$IP\n\n"Часто запрашиваемые адреса:"\n$addresses\n\n"Частые ошибки:"\n$errors" | mail -s "check msg" root@localhost
fi
