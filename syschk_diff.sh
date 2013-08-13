#!/usr/bin/ksh
SHELL=/home/se/safechk/safesh
LOG=/home/se/safechk/file/syschk
DT=`date +"%y/%m/%d %H:%M:%S"`
HOSTNAME=`hostname`

$SHELL/syschk_current.sh > $LOG/err/syschk_diff.errlog  2>&1
diff $LOG/base/syschk.${HOSTNAME}.base $LOG/check/syschk.${HOSTNAME}.now > $LOG/result/syschk.diff.`date +"%Y%m%d"` 2> $LOG/err/syschk_diff.errlog

echo "########################################################" >> $LOG/syschk_diff.log
echo "Start Time $DT" >> $LOG/syschk_diff.log

if [[ -s $LOG/result/syschk.diff.`date +"%Y%m%d"` ]];then
	echo "Hostname:$HOSTNAME  Error" >> $LOG/syschk_diff.log
	echo "Hostname:$HOSTNAME  Please to check the file $LOG/result/syschk.diff.`date +"%Y%m%d"`" >> $LOG/syschk_diff.log
	tail -4 $LOG/syschk_diff.log
else
	echo "Hostname:$HOSTNAME  OK." >> $LOG/syschk_diff.log
	tail -3 $LOG/syschk_diff.log
fi

