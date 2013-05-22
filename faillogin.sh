#!/usr/bin/sh
#
#----------------------------------
# Set variable
#----------------------------------
ApName="faillogin"
ApVers="1.0"
hostname=`hostname`
timestamp=`date +"%Y%m%d%H%M%S"`
dt=`date +"%y/%m/%d %H:%M:%S"`
loginfile="/home/se/safechk/safelog/safelog.${hostname}.faillogin.$timestamp.txt"
yt1=`/usr/bin/perl -e 'use POSIX qw(strftime);$str = strftime( "%b %m %d", localtime(time-86400));print $str'`
y_mon=`echo $yt1 | awk '{printf("%s",$1)}'`
y_day=`echo $yt1 | awk '{printf("%s",$3)}'`

#----------------------------------
# Retrieve fail login information
#----------------------------------
echo "" >> $loginfile
echo "App: $ApName v${ApVers} @ $hostname" >> $loginfile
echo "Now: $dt" >> $loginfile
echo "Target(Yesterday): $y_mon , $y_day" >> $loginfile
who -a /etc/security/failedlogin|grep "$y_mon $y_day"| grep -v "UNKNOWN_" >> $loginfile 

exit
