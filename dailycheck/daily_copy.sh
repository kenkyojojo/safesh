#!/bin/ksh
#
#----------------------------------
# Set variable
#----------------------------------
hostname=`hostname`
wkserver="WKLPAR"
DATE=`date +%Y%m%d`
DATE2=`date +%Y%m`

LOGDIR=/home/se/safechk/safelog
FILEDIR=/home/se/safechk/file/fileaudit
ACCOUNTDIR=/home/se/safechk/file/account
BASEFILE=$FILEDIR/base/${hostname}_file_attr.bas
CURRENT=$FILEDIR/check/${hostname}_`date +%Y%m%d_file_attr.chk`
FILECHG=$LOGDIR/${hostname}_`date +%Y%m%d_file_attr.chg`
LOG=/home/se/safechk/safesh/dailycheck/dailycheck.log
SELOG=/home/se/safechk/selog

#fileaudit for Daily_chk
cp -p $LOGDIR/safelog.$hostname.fileattr.$DATE /home/se/chk/fileaudit/safelog.fileattr.today

#-----------------------
# Copy logfile to Working LPAR
#-----------------------
STEP1() {
   echo Date: `date +%Y/%m/%d\ %H:%M:%S` 'scp csv to Working LPAR Start' >> $LOG
   scp -P 2222 $LOGDIR/safelog.${hostname}.fileattr.`date +%Y%m%d` $wkserver:$SELOG/chg/
   scp -P 2222 $BASEFILE $wkserver:$SELOG/chg/
   scp -P 2222 $CURRENT $wkserver:$SELOG/chg/
   scp -P 2222 $FILECHG $wkserver:$SELOG/chg/
   scp -P 2222 $LOGDIR/$DATE2.$hostname.*.txt $wkserver:$SELOG/log/
   scp -P 2222 $LOGDIR/$DATE2.$hostname.*.csv $wkserver:$SELOG/csv/
   scp -P 2222 $ACCOUNTDIR/result/${hostname}_`date +%Y%m%d_user_attr.rst` $wkserver:$SELOG/itm/
   scp -P 2222 $FILEDIR/result/${hostname}_`date +%Y%m%d_file_attr.rst` $wkserver:$SELOG/itm/
   scp -P 2222 /var/log/syslog/$hostname.syslog.${DATE}.tar.gz $wkserver:$SELOG/log/
   chown -R useradm:security $SELOG
   echo Date: `date +%Y/%m/%d\ %H:%M:%S` 'scp csv to Working LPAR End' >> $LOG
}

#-----------------------
# Clear logfile
#-----------------------
STEP2() {
   for log_type in history login sulog wtmp faillogin account fileattr
   do
      for log_file_name in `ls $LOGDIR | grep safelog.$hostname.$log_type.$DATE`
      do
        rm $LOGDIR/$log_file_name
      done
   done

   for log_type in expire last
   do
      for log_file_name in `ls $LOGDIR | grep pwlog.$hostname.$log_type.$DATE`
      do
         rm $LOGDIR/$log_file_name
      done
   done

   if [ -f $FILECHG ]; then
      rm $FILECHG
   fi
}

STEP1
STEP2

exit
