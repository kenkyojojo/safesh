#!/bin/ksh

hostname=`hostname`
ACCOUNT=/home/se/safechk/file/account
ACCOUNTSH=/home/se/safechk/safesh/dailycheck/account
ACCOUNTLOG=/home/se/safechk/safelog

$ACCOUNTSH/chkaccount.sh > $ACCOUNTLOG/safelog.${hostname}.account.`date +%Y%m%d` 2> $ACCOUNT/err/safelog.${hostname}.account.`date +%Y%m%d.err`
chown useradm:security $ACCOUNTLOG/safelog.${hostname}.account.`date +%Y%m%d`
cat $ACCOUNTLOG/safelog.${hostname}.account.`date +%Y%m%d`

exit
