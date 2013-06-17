#!/bin/ksh
#
#----------------------------------
# Set variable
#----------------------------------
hostname=`hostname`
wkserver="WKLPAR"
DATE=`date +%Y%m%d`
DATE2=`date +%Y%m`

debugmod="1"		# for debug! (1=on , 0=off)
LOGDIR=/home/se/safechk/safelog
CHKDIR=/home/se/chk/fileaudit
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
# Show running step status
#-----------------------
tlog() {
    msg=$1
	if [ "$debugmod" = "1" ]; then
		dt=`date +"%y/%m/%d %H:%M:%S"`
		echo " [${dt}] $msg"
	fi
}

#-----------------------
# Copy logfile to Working LPAR
#-----------------------
STEP1() {
	tlog "Running STEP1 ....."    
    echo Date: `date +%Y/%m/%d\ %H:%M:%S` 'scp csv to Working LPAR Start' >> $LOG
    scp -P 2222 $BASEFILE $wkserver:$SELOG/chg/ 2>/dev/null
    scp -P 2222 $CURRENT $wkserver:$SELOG/chg/ 2>/dev/null
    scp -P 2222 $FILECHG $wkserver:$SELOG/chg/ 2>/dev/null
    scp -P 2222 $LOGDIR/$DATE2.$hostname.*.txt $wkserver:$SELOG/log/ 2>/dev/null
    scp -P 2222 $LOGDIR/$DATE2.$hostname.*.csv $wkserver:$SELOG/csv/ 2>/dev/null
    scp -P 2222 $ACCOUNTDIR/result/${hostname}_`date +%Y%m%d_user_attr.rst` $wkserver:$SELOG/itm/ 2>/dev/null
    scp -P 2222 $FILEDIR/result/${hostname}_`date +%Y%m%d_file_attr.rst` $wkserver:$SELOG/itm/ 2>/dev/null
    scp -P 2222 /var/log/syslog/$hostname.syslog.${DATE}.tar.gz $wkserver:$SELOG/log/ 2>/dev/null
    chown -R useradm:security $SELOG
    echo Date: `date +%Y/%m/%d\ %H:%M:%S` 'scp csv to Working LPAR End' >> $LOG
}

#-----------------------
# Clear logfile
#-----------------------
STEP2() {
#Don't to delete ther filattr file on every day.
#for log_type in history login sulog wtmp faillogin account fileattr
	tlog "Running STEP2 ....."    
    echo Date: `date +%Y/%m/%d\ %H:%M:%S` 'Clean log LPAR Start' >> $LOG
    for log_type in history login sulog wtmp faillogin account 
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
    echo Date: `date +%Y/%m/%d\ %H:%M:%S` 'Clean log LPAR End' >> $LOG
}

#-----------------------
# Scp fileaudit detail file to WKLPAR if fileaudit check status is Failed.
#-----------------------
STEP3() {
	tlog "Running STEP3 ....."    
    echo Date: `date +%Y/%m/%d\ %H:%M:%S` 'scp fileaudit to Working LPAR Start' >> $LOG
	CHKSTATUS=`grep 'Failed' $CHKDIR/fileaudit.status| wc -l`

	if [ $hostname != "WKLPAR" ];then
		if [ $CHKSTATUS -gt 0 ];then
    		scp -P 2222 $LOGDIR/safelog.$hostname.fileattr.$DATE $wkserver:$SELOG/log/ 2>/dev/null
		fi
	else
		if [ $CHKSTATUS -gt 0 ];then
    		cp  $LOGDIR/safelog.$hostname.fileattr.$DATE $wkserver:$SELOG/log/ 2>/dev/null
		fi
			tar -cf - $SELOG/log/safelog.*.fileattr.$DATE  | gzip  > $SELOG/log/safelog.*.fileattr.$DATE.err.tar.gz 2>/dev/null
			find $SELOG/log/ -type f -mtime +14 -name "safelog.*.fileattr.*.err.tar.gz" -exec rm {} \;
			rm -f $SELOG/log/safelog.*.fileattr.$DATE 2>/dev/null
	fi
    echo Date: `date +%Y/%m/%d\ %H:%M:%S` 'scp fileaudit to Working LPAR End' >> $LOG
}

STEP1
STEP2
STEP3

exit
