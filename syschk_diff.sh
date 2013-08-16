#!/usr/bin/ksh
SHELL=/home/se/safechk/safesh
LOG=/home/se/safechk/file/syschk
CHKLOG=/home/se/safechk/safelog
DT=`date +"%y/%m/%d %H:%M:%S"`
HOSTNAME=`hostname`

$SHELL/syschk_current.sh 
diff $LOG/base/syschk.${HOSTNAME}.base $LOG/check/syschk.${HOSTNAME}.now > $LOG/result/syschk.diff.`date +"%Y%m%d"` 2> $LOG/err/syschk_diff.errlog

echo "########################################################" >> $LOG/syschk_diff.log
echo "Start Time $DT" >> $LOG/syschk_diff.log

if [[ -s $LOG/result/syschk.diff.`date +"%Y%m%d"` ]];then
	cp $LOG/result/syschk.diff.`date +"%Y%m%d"` $LOG/result/syschk.diff
	echo "$HOSTNAME  Error Please to check the file $LOG/result/syschk.diff " >> $LOG/syschk_diff.log
	tail -3 $LOG/syschk_diff.log > $CHKLOG/syschk.log
else
	echo "$HOSTNAME  OK." >> $LOG/syschk_diff.log
	tail -3 $LOG/syschk_diff.log > $CHKLOG/syschk.log
fi
