#!/bin/ksh
#
#----------------------------------
# Set variable
#----------------------------------
hostname=`hostname`
DATE2=`date +%Y%m`
TIMEH=`date +%H`
DATE1AGO=`perl -MPOSIX -le 'print strftime "%Y%m%d", localtime(time()-86400);'`
SHDIR=/home/se/safechk/safesh
LOGDIR=/home/se/safechk/safelog
LOG=${LOGDIR}/dailycheck.log
FILESH=${SHDIR}/dailycheck/fileaudit
ACCOUNTSH=${SHDIR}/dailycheck/account
FILEDIR=/home/se/safechk/file/fileaudit
ACCOUNTDIR=/home/se/safechk/file/account

# {{{STEP1
#---------------------
# Daily file check
#---------------------
STEP1() {
   echo Date: `date +%Y/%m/%d\ %H:%M:%S` 'File Check Start' >> $LOG
   cp  $FILEDIR/base/${hostname}_file_attr.bas $FILEDIR/base/${hostname}_file_attr.bas.${DATE1AGO}
   cp  $FILEDIR/base/${hostname}_file_exist.bas $FILEDIR/base/${hostname}_file_exist.bas.${DATE1AGO}
   $FILESH/filecheck.sh > $LOGDIR/safelog.${hostname}.fileattr.`date +%Y%m%d` 2> $FILEDIR/err/safelog.${hostname}.fileattr.`date +%Y%m%d.err`
   chown useradm:se $LOGDIR/safelog.${hostname}.fileattr.`date +%Y%m%d`
   chown -R useradm:se $FILEDIR/*
   chown  seadm:se $FILEDIR/base/${hostname}_file_attr.bas
   chown  seadm:se $FILEDIR/base/${hostname}_file_exist.bas
   cat $LOGDIR/safelog.${hostname}.fileattr.`date +%Y%m%d`

   find $FILEDIR/base -type f -mtime +14 -name "${hostname}_file_attr.bas.[0-9]*" -exec rm {} \;
   find $FILEDIR/base -type f -mtime +14 -name "${hostname}_file_exist.bas.[0-9]*" -exec rm {} \;
   find $FILEDIR/check -type f -mtime +14 -exec rm {} \;
   find $FILEDIR/result -type f -mtime +14 -exec rm {} \;
   find $FILEDIR/err -type f -mtime +14 -exec rm {} \;
   echo Date: `date +%Y/%m/%d\ %H:%M:%S` 'File Check End' >> $LOG
}
#}}}

# {{{ STEP2
#---------------------
# User account check
#---------------------
STEP2() {
   echo Date: `date +%Y/%m/%d\ %H:%M:%S` 'Account Check Start' >> $LOG
   $ACCOUNTSH/chkaccount.sh > $LOGDIR/safelog.${hostname}.account.`date +%Y%m%d` 2> $ACCOUNTDIR/err/safelog.${hostname}.account.`date +%Y%m%d.err`
   chown useradm:security $LOGDIR/safelog.${hostname}.account.`date +%Y%m%d`
   chown -R useradm:security $ACCOUNTDIR/*
   cat $LOGDIR/safelog.${hostname}.account.`date +%Y%m%d`

   find $ACCOUNTDIR/check -type f -mtime +14 -exec rm {} \;
   find $ACCOUNTDIR/result -type f -mtime +14 -exec rm {} \;
   find $ACCOUNTDIR/err -type f -mtime +14 -exec rm {} \;
   echo Date: `date +%Y/%m/%d\ %H:%M:%S` 'Account Check End' >> $LOG
}
#}}}

# {{{ STEP3
#----------------------
# output to safelog
#----------------------
STEP3() {
   echo Date: `date +%Y/%m/%d\ %H:%M:%S` 'safelog Start' >> $LOG
   $SHDIR/safelog.sh
   chown useradm:security $LOGDIR/*.txt
   echo Date: `date +%Y/%m/%d\ %H:%M:%S` 'safelog End' >> $LOG
}
#}}}

# {{{ STEP4
STEP4() {
#----------------------
# resort log to csv
#----------------------
   echo Date: `date +%Y/%m/%d\ %H:%M:%S` 'resort Start' >> $LOG
   $SHDIR/resort.sh
   chown useradm:security $LOGDIR/*.txt
   chown useradm:security $LOGDIR/*.csv
   echo Date: `date +%Y/%m/%d\ %H:%M:%S` 'resort End' >> $LOG
}
#}}}

# {{{ STEP5
STEP5(){
#-----------------------
# Backup syslog and crontab(root)
#-----------------------
   echo Date: `date +%Y/%m/%d\ %H:%M:%S` 'Backup syslog and crontab(root) Start' >> $LOG
   LOGPATH="/var/log/syslog"
   if [ -d $LOGPATH ]; then
      cd $LOGPATH
	  rm -f ${hostname}.syslog*.tar.gz
      crontab -l > ${hostname}.crontab.txt
	  cp -rp /var/spool/cron/crontabs $LOGPATH
      tar -cf - ./* | gzip > ${hostname}.syslog.`date +%Y%m%d`.tar.gz
      echo Date: `date +%Y/%m/%d\ %H:%M:%S` 'Backup syslog and crontab(root) End' >> $LOG
   else
      echo Date: `date +%Y/%m/%d\ %H:%M:%S` '/var/log/syslog directory not exist' >> $LOG
   fi
}
#}}}

# {{{ main
main () {
PARA=$1

	case $PARA in 
		1)
			STEP1
		;;
		2)
			STEP2
		;;
		3)
			STEP3
		;;
		4)
			STEP4
		;;
		5)
			STEP5
		;;
		*)
			STEP1
			STEP2
			STEP3
			STEP4
#			STEP5
		;;
	esac
	exit 0
}
#}}}

main $1
