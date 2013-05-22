#!/bin/ksh
#
hostname=`hostname`
FILE=/home/se/safechk/file/fileaudit
FILESH=/home/se/safechk/safesh/dailycheck/fileaudit
FILELOG=/home/se/safechk/safelog

$FILESH/filecheck.sh > $FILELOG/safelog.${hostname}.fileattr.`date +%Y%m%d` 2> $FILE/err/safelog.${hostname}.fileattr.`date +%Y%m%d.err`
chown useradm:security $FILELOG/safelog.${hostname}.fileattr.`date +%Y%m%d`
cat $FILELOG/safelog.${hostname}.fileattr.`date +%Y%m%d`

exit
