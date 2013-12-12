#!/bin/ksh
#
#----------------------------------
# Set variable
#----------------------------------
HOSTNAME=$(echo `hostname` | cut -c1-3)
DATE=`date +%Y%m%d`
DATE2=`date +%Y%m`
RPATH="/var/spool/cron/crontabs/"
RUSER="root"
SUSER="seadm"

#----------------------------------
# Main function
#----------------------------------
if [ "$HOSTNAME" == "LOG" ] ; then
   ##root
   echo "0 5 * * *  /home/se/safechk/safesh/ntp.sh > /dev/null 2>&1" >> $RPATH/$RUSER
   echo "0 1 * * *  /home/se/safechk/safesh/ckpasswd.sh > /dev/null 2>&1" >> $RPATH/$RUSER
   echo "0 4 * * *  /home/se/safechk/safesh/dailycheck/daily_check.sh > /dev/null 2>&1" >> $RPATH/$RUSER
   echo "1 0 1 * *  /home/se/safechk/safesh/monthlycheck/monthly_check.sh > /dev/null 2>&1" >> $RPATH/$RUSER

   ##seadm
   echo "45 7 * * 1-5 /home/se/chk/nmon/start_nmon.sh" >> $RPATH/$SUSER
   echo "5 7,14 * * * /home/se/chk/script/combind.sh check" >> $RPATH/$SUSER

elif [ "$HOSTNAME" == "WKL" ]; then
   ##root
   echo "0 1 * * *  /home/se/safechk/safesh/ckpasswd.sh > /dev/null 2>&1" >> $RPATH/$RUSER
   echo "0 4 * * *  /home/se/safechk/safesh/dailycheck/daily_check.sh > /dev/null 2>&1" >> $RPATH/$RUSER
   echo "1 0 1 * *  /home/se/safechk/safesh/monthlycheck/monthly_check.sh > /dev/null 2>&1" >> $RPATH/$RUSER
   echo "30 4 * * *  stopsrc -s xntpd ; /home/se/safechk/safesh/ntp.sh > /dev/null 2>&1 ; startsrc -s xntpd" >> $RPATH/$RUSER
   echo "0 5 * * *  /home/se/safechk/safesh/startcopy.sh > /dev/null 2>&1" >> $RPATH/$RUSER
   echo "0 6 * * *  /home/se/safechk/safesh/filechgall.sh > /dev/null 2>&1" >> $RPATH/$RUSER
   echo "#" >> $RPATH/$RUSER
#   echo "50 6 * * *  /TWSE/MIS/SE/tcpdump/start_dump.sh > /dev/null 2>&1" >> $RPATH/$RUSER
#   echo "0 9 * * *  /TWSE/MIS/SE/tcpdump/kill_tcpdump.sh > /dev/null 2>&1" >> $RPATH/$RUSER
#   echo "#" >> $RPATH/$RUSER
   echo "55 23 * * * /var/perf/pm/bin/pmcfg >/dev/null 2>&1      #Enable PM Data Collection" >> $RPATH/$RUSER

   ##seadm
   echo "45 7 * * 1-5 /home/se/chk/nmon/start_nmon.sh" >> $RPATH/$SUSER
   echo "5 7,14 * * * /home/se/chk/script/combind.sh check" >> $RPATH/$SUSER

else
   ##root
   echo "0 5 * * *  /home/se/safechk/safesh/ntp.sh > /dev/null 2>&1" >> $RPATH/$RUSER
   echo "0 1 * * *  /home/se/safechk/safesh/ckpasswd.sh > /dev/null 2>&1" >> $RPATH/$RUSER
   echo "0 4 * * *  /home/se/safechk/safesh/dailycheck/daily_check.sh > /dev/null 2>&1" >> $RPATH/$RUSER
   echo "1 0 1 * *  /home/se/safechk/safesh/monthlycheck/monthly_check.sh > /dev/null 2>&1" >> $RPATH/$RUSER
#   echo "50 6 * * *  /TWSE/MIS/SE/tcpdump/start_dump.sh > /dev/null 2>&1" >> $RPATH/$RUSER
#   echo "0 9 * * *  /TWSE/MIS/SE/tcpdump/kill_tcpdump.sh > /dev/null 2>&1" >> $RPATH/$RUSER
   echo "55 23 * * * /var/perf/pm/bin/pmcfg >/dev/null 2>&1      #Enable PM Data Collection" >> $RPATH/$RUSER

   ##seadm
   echo "45 7 * * 1-5 /home/se/chk/nmon/start_nmon.sh" >> $RPATH/$SUSER
   echo "5 7,14 * * * /home/se/chk/script/combind.sh check" >> $RPATH/$SUSER
fi

exit
