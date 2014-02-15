#! /usr/bin/ksh
#
#----------------------------------
# Set variable
#----------------------------------
HOSTLIST=`cat /home/se/safechk/cfg/host.lst`
LOG=/home/se/safechk/safelog/dailycheck.log
USER=$(whoami)
HOMEDIR=`lsuser $USER | awk '{print $5}' | cut -c6-`
timestamp=`date +%Y%m%d`

echo "#======================startcopy.sh   Start==================#" >> $LOG
#----------------------------------
# Start to rm file.attr.chk file.attr.chg
#----------------------------------
STEP1(){
for file in chk chg 
do
	find /home/se/safechk/selog/chg -type f -mtime 3 -name "*attr.${file}" -exec rm {} \;
done
}

#----------------------------------
# Start remote copy filecheck file
#----------------------------------
STEP2(){
for HOST in $HOSTLIST ; do
   ssh -p 2222 $HOST "/home/se/safechk/safesh/dailycheck/daily_copy.sh"
   execStatus=$?
   if [ $execStatus -eq 0 ]; then
      echo Date: `date +%Y/%m/%d\ %H:%M:%S` "$HOST COPY OK!" >> $LOG
   else
      echo Date: `date +%Y/%m/%d\ %H:%M:%S` "$HOST COPY Fail!" >> $LOG
   fi
done

}
#----------------------------------
# Start tar selog dir 
#----------------------------------
STEP3(){
	cd /home/se/safechk
	tar -cf - selog | gzip  > selog.${timestamp}.tar.gz
	chown useradm:security selog.${timestamp}.tar.gz
	mv selog.${timestamp}.tar.gz /home/se/safechk/backup
}
#exit 0

#STEP1 #It change to use  filechg.sh to rm the fileaudit's chk or chg file.
STEP2
#STEP3 #No 

echo "#======================startcopy.sh   End====================#" >> $LOG
