#!/usr/bin/ksh
# This script is for daily check.
# 2012/03/02 by Coventive
#
#
DIR=$1
CHK_TIME=`date +%Y%m%d_%H:%M:%S`
HOSTNAME=`hostname`
NUM=18
#FEAUDITLOG=/home/se/safechk/safelog/safelog.${HOSTNAME}.fileattr.`date +%Y%m%d`
FEAUDITCHK=/home/se/chk/fileaudit/safelog.fileattr.today

#cat $FEAUDITLOG > $FEAUDITCHK

STATUS=$(grep 'Faile' $DIR/fileaudit/fileaudit.status | wc -l)
if [[ -e $DIR/fileaudit/fileaudit.status ]] && [[ $STATUS -lt 1 ]]; then
        echo "$NUM\t$HOSTNAME\tfileaudit\t$CHK_TIME\t0\tOK\t" | tee $DIR/result/fileaudit_result
else
        echo "$NUM\t$HOSTNAME\tfileaudit\t$CHK_TIME\t0\tFAIL\t Please to check the File $FEAUDITCHK" | tee $DIR/result/fileaudit_result
fi
