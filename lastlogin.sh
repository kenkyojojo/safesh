#!/usr/bin/sh
#
#----------------------------------
# Set variable
#----------------------------------
ApName="lastlogin"
ApVers="1.1a"
hostname=`hostname`
timestamp=`date +"%Y%m%d%H%M%S"`
dt=`date +"%y/%m/%d %H:%M:%S"`
loginfile="/home/se/safechk/safelog/safelog.${hostname}.login.$timestamp.txt"
yt1=`/usr/bin/perl -e 'use POSIX qw(strftime);$str = strftime( "%b %m %d", localtime(time-86400));print $str'`
y_mon=`echo $yt1 | awk '{printf("%s",$1)}'`
y_day=`echo $yt1 | awk '{printf("%s",$3)}'`


#----------------------------------
# Retrieve last login information
#----------------------------------
echo "" >> $loginfile
echo "App: $ApName v${ApVers} @ $hostname" >> $loginfile
echo "Now: $dt" >> $loginfile
echo "Target(Yesterday): $y_mon , $y_day" >> $loginfile
last|grep "$y_mon $y_day" >> $loginfile 

exit
