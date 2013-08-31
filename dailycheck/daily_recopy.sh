#!/bin/ksh
#
#----------------------------------
# Set variable
#----------------------------------
hostname=`hostname`
wkserver="WKLPARA1"
DATE2=`date +%Y%m`
LOGDIR=/home/se/safechk/safelog
FILEDIR=/home/se/safechk/file/fileaudit
ACCOUNTDIR=/home/se/safechk/file/account
LOG=/home/se/safechk/safesh/dailycheck/dailycheck.log
SELOG=/home/se/safechk/selog


#-----------------------
# Copy logfile to Working LPAR
#-----------------------
echo Date: `date +%Y/%m/%d\ %H:%M:%S` 'scp csv to Working LPAR Start' >> $LOG
scp -P 2222 $LOGDIR/$DATE2.$hostname.*.txt $wkserver:$SELOG/log/
scp -P 2222 $LOGDIR/$DATE2.$hostname.*.csv $wkserver:$SELOG/csv/
scp -P 2222 $FILEDIR/result/${hostname}_`date +%Y%m%d_file_attr.rst` $wkserver:$SELOG/itm/
scp -P 2222 $ACCOUNTDIR/result/${hostname}_`date +%Y%m%d_user_attr.rst` $wkserver:$SELOG/itm/
chown -R useradm:security $SELOG
echo Date: `date +%Y/%m/%d\ %H:%M:%S` 'scp csv to Working LPAR End' >> $LOG


exit
