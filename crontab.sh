#!/bin/ksh
#
#----------------------------------
# Set variable
#----------------------------------
HOSTNAME=`hostname`
DATE=`date +%Y%m%d`
DATE2=`date +%Y%m`
RPATH="/var/spool/cron/crontabs/"
RUSER="root"
SUSER="seadm"

#----------------------------------
# Main function
#----------------------------------
if [ "$HOSTNAME" == "LOG2" ] ; then
   ##root
   echo "0 5 * * *  /home/se/safechk/safesh/ntp.sh > /dev/null 2>&1" >> $RPATH/$RUSER
   echo "0 1 * * *  /home/se/safechk/safesh/ckpasswd.sh > /dev/null 2>&1" >> $RPATH/$RUSER
   echo "0 4 * * *  /home/se/safechk/safesh/dailycheck/daily_check.sh > /dev/null 2>&1" >> $RPATH/$RUSER
   echo "0 5 * * *  /home/se/safechk/safesh/dailycheck/daily_copy.sh > /dev/null 2>&1" >> $RPATH/$RUSER
   echo "1 0 1 * *  /home/se/safechk/safesh/monthlycheck/monthly_check.sh > /dev/null 2>&1" >> $RPATH/$RUSER

   ##seadm
   echo "45 7 * * 1-5 /home/se/chk/nmon/start_nmon.sh" >> $RPATH/$SUSER
   echo "40 6 * * *  /TWSE/MIS/SE/lbmmon/start_lbmmon.sh > /dev/null 2>&1" >> $RPATH/$SUSER
   echo "0 19 * * *  /TWSE/MIS/SE/lbmmon/kill_lbmmon.sh > /dev/null 2>&1" >> $RPATH/$SUSER
   echo '0 7,14 * * 1-5 /home/se/chk/check.sh "/home/se/chk" >> /home/se/chk/report/`date \+\%Y\%m\%d`.report ; tail -n 17 /home/se/chk/report/`date \+\%Y\%m\%d`.report >> /home/se/chk/report/today.report' >> $RPATH/$SUSER
else
   ##root
   echo "0 5 * * *  /home/se/safechk/safesh/ntp.sh > /dev/null 2>&1" >> $RPATH/$RUSER
   echo "0 1 * * *  /home/se/safechk/safesh/ckpasswd.sh > /dev/null 2>&1" >> $RPATH/$RUSER
   echo "0 4 * * *  /home/se/safechk/safesh/dailycheck/daily_check.sh > /dev/null 2>&1" >> $RPATH/$RUSER
   echo "0 5 * * *  /home/se/safechk/safesh/dailycheck/daily_copy.sh > /dev/null 2>&1" >> $RPATH/$RUSER
   echo "1 0 1 * *  /home/se/safechk/safesh/monthlycheck/monthly_check.sh > /dev/null 2>&1" >> $RPATH/$RUSER
   echo "50 6 * * *  /TWSE/MIS/SE/tcpdump/start_dump.sh > /dev/null 2>&1" >> $RPATH/$RUSER
   echo "0 9 * * *  /TWSE/MIS/SE/tcpdump/kill_tcpdump.sh > /dev/null 2>&1" >> $RPATH/$RUSER

   ##seadm
   echo "45 7 * * 1-5 /home/se/chk/nmon/start_nmon.sh" >> $RPATH/$SUSER
   echo '0 7,14 * * * /home/se/chk/check.sh "/home/se/chk" >> /home/se/chk/report/`date \+\%Y\%m\%d`.report ; tail -n 17 /home/se/chk/report/`date \+\%Y\%m\%d`.report >> /home/se/chk/report/today.report' >> $RPATH/$SUSER
fi

exit
