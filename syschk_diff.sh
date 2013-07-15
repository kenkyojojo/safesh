#!/usr/bin/ksh
SHELL=/home/se/safechk/safesh
LOG=/home/se/safechk/file/syschk
DT=`date +"%y/%m/%d %H:%M:%S"`
HOSTNAME=`hostname`

$SHELL/syschk_current.sh 
diff $LOG/base/syschk.${HOSTNAME}.base $LOG/check/syschk.${HOSTNAME}.now > $LOG/result/syschk.diff.`%y%m%d` 2> $LOG/err/syschk_diff.errlog

echo "########################################################" >> $LOG/syschk_diff.log
echo "Start Time $DT" >> $LOG/syschk_diff.log

if [[ -s $LOG/result/syschk.diff  ]];then
	echo "$HOSTNAME  Error" >> $LOG/syschk_diff.log
	echo "$HOSTNAME  Please to check the file $LOG/result/syschk.diff" >> $LOG/syschk_diff.log
else
	echo "$HOSTNAME  OK." >> $LOG/syschk_diff.log
fi
