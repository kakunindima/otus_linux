#!/bin/bash
###otus-linux hometask Bash-script for parsing log file

###Environments
logfile=access-4560-644067.log
envfile=envfile.txt
num_old=`cat $envfile | grep num | awk -F"=" '{ print $2}'` #номер строки на которой остановились
num_curr=`cat $logfile | wc -l` #получаем общее кол-во строк в файле

#Функиця подсчета значений
rasch() {
    #Удаляем файл предыдушего выполнения скрипта
    rm test.txt
    #Подсчет ip-адрессов
    echo "Статистика запросов от ip-адрессов:" >> test.txt
    tail -n+$num_old $logfile | awk -F"-" '{print $1}' | sort -nr | uniq -c | sort -nr >> test.txt

    #Подсчет запрашиваемых страниц
    echo "Статистика запрашиваемых адрессов:" >> test.txt
    tail -n+$num_old $logfile | awk -F'"' '{print $2}' | awk -F " " '{print $2}' | sort -nr | uniq -c | sort -nr >> test.txt

    #Подсчет кодов возврата
    echo "Статистика кодов возврата:" >> test.txt
    tail -n+$num_old $logfile | awk -F'"' '{print $3}' | awk -F " " '{print $1}' | sort -nr | uniq -c | sort -nr >> test.txt

    #Подсчет кодов ошибок
    echo "Статистика кодов ошибок:" >> test.txt
    tail -n+$num_old $logfile | awk -F'"' '{print $3}' | awk -F " " '{print $1}'| awk '/[4-5][0-9][0-9]/' | sort -nr | uniq -c | sort -nr >> test.txt
    echo "Прочитано $n строк" >> test.txt
}

#Проверка на очистку файла лога:
    # если файл лога был очищен то присваиваем 0 значение порядковой переменной для запуска прогона чтения файла с начала строк
    # если строки в файле добавились то вычиляем разницу строк - и начинаем прогон со следующей
if (($num_old > $num_curr));
    then
	num_old=0
    else
	let n=$num_curr-$num_old
	let num_old=$num_curr-$n+1
fi
#Вносим значения последней строки файла для последующего считывания и вычислений
#rm $envfile
sed -i "s/.*/num=$num_curr/g" $envfile

#echo "num="$num_curr > envfile.txt
#цикл для парсинга файла
#for (( i=$num_old; i < $num_curr; i++ )) {
#	echo $num_old
#	echo $num_curr
#}
rasch
