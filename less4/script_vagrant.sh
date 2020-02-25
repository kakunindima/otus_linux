#!/bin/bash
###otus-linux hometask Bash-script for parsing log file

###Environments
scr_dirr=/srv/scripts/otus_linux/less4
logfile=$scr_dirr/access-4560-644067.log
envfile=$scr_dirr/envfile.txt
num_old=`cat $envfile | grep num | awk -F"=" '{ print $2}'` #номер строки на которой остановились
num_curr=`cat $logfile | wc -l` #получаем общее кол-во строк в файле
timestamp_last=`cat $envfile | grep timestamp_last | awk -F"=" '{ print $2}'` #Получаем значение времени последнего запуска скрипта
lockfile=/tmp/localfile

#Функция расчета временного промежутка
time_func() {
    date_curr=`date '+%Y-%m-%d %H:%M:%S'`
    echo "Временной диапазон анализа скрипта $timestamp_last - $date_curr" >> $scr_dirr/mail.txt
    sed -i "s/timestamp_last=.*/timestamp_last=$date_curr/g" $envfile
}
#Функиця подсчета значений
parsing() {
    echo ""
    #Подсчет ip-адрессов
    echo "Статистика запросов от ip-адрессов:" >> $scr_dirr/mail.txt
    tail -n+$num_old $logfile | awk -F"-" '{print $1}' | sort -nr | uniq -c | sort -nr >> $scr_dirr/mail.txt
    echo "_____________________________________________" >> $scr_dirr/mail.txt
    #Подсчет запрашиваемых страниц
    echo "Статистика запрашиваемых адрессов:" >> $scr_dirr/mail.txt
    tail -n+$num_old $logfile | awk -F'"' '{print $2}' | awk -F " " '{print $2}' | sort -nr | uniq -c | sort -nr >> $scr_dirr/mail.txt
    echo "_____________________________________________" >> $scr_dirr/mail.txt
    #Подсчет кодов возврата
    echo "Статистика кодов возврата:" >> $scr_dirr/mail.txt
    tail -n+$num_old $logfile | awk -F'"' '{print $3}' | awk -F " " '{print $1}' | sort -nr | uniq -c | sort -nr >> $scr_dirr/mail.txt
    echo "_____________________________________________" >> $scr_dirr/mail.txt
    #Подсчет кодов ошибок
    echo "Статистика кодов ошибок:" >> $scr_dirr/mail.txt
    tail -n+$num_old $logfile | awk -F'"' '{print $3}' | awk -F " " '{print $1}'| awk '/[4-5][0-9][0-9]/' | sort -nr | uniq -c | sort -nr >> $scr_dirr/mail.txt
    echo "_____________________________________________" >> $scr_dirr/mail.txt
    echo "Прочитано $n строк из $logfile" >> $scr_dirr/mail.txt
}

#Функция проверки очистки файла лога:
clear_log() {
    # если файл лога был очищен то присваиваем 0 значение порядковой переменной для запуска прогона чтения файла с начала строк
    # если строки в файле добавились то вычиляем разницу строк - и начинаем прогон со следующей
    if (($num_old > $num_curr));
	then
	    num_old=0
	    let n=$num_curr
	else
	    let n=$num_curr-$num_old
	    let num_old=$num_curr-$n+1
    fi
    #Вносим значения последней строки файла для последующего считывания и вычислений
    sed -i "s/num=.*/num=$num_curr/g" $envfile
}

#Функция проверки повторного запуска файла
launch_chk() {
    if ( set -o noclobber; echo `ps -a | grep script.sh`  > "$lockfile") 2> /dev/null;
	then
	trap 'rm -f "$lockfile"; exit $?' INT TERM EXIT
	while true
	    do
	    #Удаляем файл предыдушего письма
	    rm mail.txt
	    #Launch func
	    clear_log
	    time_func
	    parsing
	    sleep 15s
	    #Send mail
	    mail -s "Statistic" root@localhost < mail.txt
	    exit
	done
	rm -f "$lockfile"
	 trap - INT TERM EXIT
    else
	echo "Failed to launch script..."
	echo "The script is launched by proc: $(cat $lockfile)"

    fi
}

launch_chk