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
flag_file="/home/se/safechk/safelog/faillogin.flag"

#----------------------------------
# Test the flag_file exist
#----------------------------------
	if [[ ! -f $flag_file ]]; then
		touch $flag_file
		echo "0" > $flag_file
		chown useradm:security $flag_file
		chmod 664 $flag_file
	fi
#----------------------------------
# Load the flag_file number and compare with the current status
#----------------------------------
flag_org=`cat $flag_file`
flag_cur=`who -a /etc/security/failedlogin| grep -v "UNKNOWN" | wc -l |awk '{print $1}'`
(( flag_dif=$flag_cur - $flag_org ))

	if [[ $flag_cur -eq $flag_org ]] ; then
		echo "" >> $loginfile
		echo "App: $ApName v${ApVers} @ $hostname" >> $loginfile
		echo "Now: $dt" >> $loginfile
		echo "Target(Yesterday): $y_mon , $y_day" >> $loginfile

		exit
	elif [[ $flag_cur -gt $flag_org ]] ;then
		echo "" >> $loginfile
		echo "App: $ApName v${ApVers} @ $hostname" >> $loginfile
		echo "Now: $dt" >> $loginfile
		echo "Target(Yesterday): $y_mon , $y_day" >> $loginfile
		who -a /etc/security/failedlogin|grep -v "UNKNOWN"|tail -n $flag_dif  >> $loginfile 
		#update the $flag_file
		echo $flag_cur > $flag_file
	else 
		echo "" >> $loginfile
		echo "App: $ApName v${ApVers} @ $hostname" >> $loginfile
		echo "Now: $dt" >> $loginfile
		echo "Target(Yesterday): $y_mon , $y_day" >> $loginfile

		echo "The \$flag_org=$flag_org greater than \$flag_cur=$flag_cur" >> $loginfile
	fi
#----------------------------------
# Retrieve fail login information
#----------------------------------
#echo "" >> $loginfile
#echo "App: $ApName v${ApVers} @ $hostname" >> $loginfile
#echo "Now: $dt" >> $loginfile
#echo "Target(Yesterday): $y_mon , $y_day" >> $loginfile
#who -a /etc/security/failedlogin|grep "$y_mon $y_day"| grep -v "UNKNOWN_" >> $loginfile 

#exit
