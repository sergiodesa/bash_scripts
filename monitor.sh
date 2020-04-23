#!/bin/sh
#
# Ver 1.2 22/01/2014
# ADD IOSTAT
# Modify MYsql prunes, as now shows the increase from last time checked
# Clean way script displays info
#
#
# ver 1.1 29/07/2012
# Add Swap memory
# Add mysql prunes
# Some clean + automatition
#
# ver 1.0 16/02/2011
server=`uname -n | cut -d. -f1`
mem_use=`free -t -m | egrep Mem | awk '{print $3}'`
mem_free=`free -t -m | egrep Mem | awk '{print $4}'`
sw_use=`free -t -m | egrep Swap | awk '{print $3}'`
temp_pr=`mysql -e 'show status' | grep prunes | awk '{print $2}'`
httpd_cnt=`ps auxww | grep 'httpd'| grep -v grep | wc -l`
mysql_status=`/usr/bin/mysqladmin -u root status`
load=`/bin/cat /proc/loadavg | awk '{print $1}'`
proc=`/bin/cat /proc/loadavg | awk '{print $4}'`
now=`date "+%d-%m-%Y %H:%M:%S"`
today=`date "+%d-%m"`
iow=`iostat -c | egrep "^ " |awk '{print $4}'`
ioi=`iostat -c | egrep "^ " |awk '{print $6}'`
logfile=~/log/monitor.log
temp_logfile=~/log/tmonitor.log
pr_old=`tail -n1 ~/log/tmonitor.log  | awk '{print $1}'`
pr_new=`mysql -e 'show status' | grep prunes | awk '{print $2}'`
pr=`expr $pr_new  - $pr_old`
lock=~/log/monitor.lock

if [ -e $lock ]; then
  # Already running
  exit
fi;

touch $lock;

if [ ! -e $logfile ]; then
  echo "Relatorio de controlo da maquina $server" > $logfile;
fi
echo $temp_pr > $temp_logfile
echo $now Load= $load Process: $proc Apache: $httpd_cnt MEMORY= $mem_use Used $mem_free Free $sw_use Swap IOSTATS= $iow wait $ioi idle PRUNES SINCE LAST CHECK $pr >> $logfile;
rm -f $lock;

