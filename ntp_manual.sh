#!/usr/bin/ksh
#
#----------------------------------
# Set variable
#----------------------------------
hostname=$(echo `hostname` | cut -c1-5)
timestamp=`date +"%Y%m%d%H%M"`
wkserver="WKLPAR"
TIME=0

if [ $hostname != $wkserver ]; then
   NTPSERVER=`tail -1 /home/se/safechk/cfg/ntp.lst`
else
   NTPSERVER=`head -1 /home/se/safechk/cfg/ntp.lst`
fi

#----------------------------------
# ntp check
#----------------------------------
TIME=`/usr/sbin/ntpdate -d $NTPSERVER | grep ^offset | awk '{print $2}' | sed 's/^-//'`


if [[ $TIME -lt 2 ]]; then
   /usr/sbin/ntpdate -b $NTPSERVER > /home/se/chk/check/ntp/`date \+\%Y\%m\%d`_ntp
   echo ""
   cat /home/se/chk/check/ntp/`date \+\%Y\%m\%d`_ntp > /home/se/chk/ntp/ntp.result
   echo ""
else
   echo "$TIME greater than 2"
   echo ""
   /usr/sbin/ntpdate -b $NTPSERVER > /home/se/chk/check/ntp/`date \+\%Y\%m\%d`_ntp
   cat /home/se/chk/check/ntp/`date \+\%Y\%m\%d`_ntp > /home/se/chk/ntp/ntp.result
   echo ""
fi
