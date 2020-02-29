#!/bin/bash
#variabless
prc=`ls /proc | grep [0-9] | sort -n`
#main func
for i in $prc
    do
	awk -F" " '{print "PID:"$1,"PPID:"$4,"STATUS:"$3,"NICE:"$19,"PROCESS:"$2}' /proc/$i/stat | column -t
    done