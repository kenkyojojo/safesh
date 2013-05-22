#!/bin/sh
#
#----------------------------------
# Set variable
#----------------------------------
HOSTNAME=`hostname`
DATE=`date +%Y%m%d`
DATE2=`date +%Y%m`
DATAPATH="/home/se/safechk/safelog"


#----------------------------------
# safelog to csv
# name rules: safelog.dev1.login.201204
#----------------------------------
/home/se/safechk/safesh/log2csv.sh



#----------------------------------
# daily safelog to monthly safelog
#----------------------------------
for log_type in history login sulog wtmp faillogin account fileattr
do
   for log_file_name in `ls $DATAPATH | grep safelog.$HOSTNAME.$log_type.$DATE`
   do
     echo $log_file_name
     cat $DATAPATH/$log_file_name >> $DATAPATH/$DATE2.$HOSTNAME.$log_type.txt
   done
done

for log_type in expire last
do
   for log_file_name in `ls $DATAPATH | grep pwlog.$HOSTNAME.$log_type.$DATE`
   do
      echo $log_file_name
      cat $DATAPATH/$log_file_name >> $DATAPATH/$DATE2.$HOSTNAME.$log_type.txt
   done
done

exit
