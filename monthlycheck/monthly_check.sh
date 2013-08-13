#!/bin/ksh
#
#----------------------------------
# Set variable
#----------------------------------
hostname=`hostname`
DATE2=`date +%Y%m`
LOGDIR=/home/se/safechk/safelog
LOG=/home/se/safechk/safesh/safelog/monthlycheck.log
BIN=/home/se/safechk/safesh
now_year=`date +"%Y"`
yt1=`/usr/bin/perl -e 'use POSIX qw(strftime);$str = strftime( "%b %m %d", localtime(time-86400));print $str'`
now_mon=`echo $yt1 | awk '{printf("%s",$2)}'`
let last_mon=$now_mon-1
last_mon=`printf "%.2d" $last_mon`


#---------------------
# monthly userlock reset
#---------------------
STEP1() {
   echo Date: `date +%Y/%m/%d\ %H:%M:%S` 'monthly userlock reset Start' >> $LOG
   $BIN/usrlock_reset.sh
   echo Date: `date +%Y/%m/%d\ %H:%M:%S` 'monthly userlock reset End' >> $LOG
}

#-----------------------
# monthly Backup (csv txt)
#-----------------------
STEP2(){
   echo Date: `date +%Y/%m/%d\ %H:%M:%S` 'Monthly Backup Start' >> $LOG
   cd $LOGDIR

   tar -cf - ./${now_year}${last_mon}.* | gzip > ${hostname}.${now_year}${last_mon}.tar.gz
   chown useradm:security ${hostname}.${now_year}${last_mon}.tar.gz
   rm -f ${now_year}${last_mon}.*
   echo Date: `date +%Y/%m/%d\ %H:%M:%S` 'Monthly Backup End' >> $LOG
}


STEP1
STEP2

exit
