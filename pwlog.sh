#!/bin/ksh

#
# pwlog.sh
# paul@coventive.com 2012/04/06
#
# Subject:
# 1. find user's last login
# 2. show user's pw left/exceed daytime
#
# Usage:
# ./pwlog.sh [enter]              # userlist depend on want_users & skip_users
# ./pwlog.sh user1 user2 [enter]  # userlist = "user1 user2"
#
# Ref:
# http://www.ibm.com/developerworks/cn/aix/library/au-password_expiry/index.html
#
# History:
# 2012/04/06 1.0a Prototype.
# 2012/04/09 1.1a Fix findPwLeftTime::left/exceed, check lastUpdate.
#

#----------------------------------
# Set variable
#----------------------------------
ApName="pwlog"
ApVers="1.1a"
hostname=`hostname`

# skip_users & want_users were prepared for doing "genUserList"
# priority: (1) if exist want_users (2) all users exclude skip_users
skip_users="[ daemon bin sys adm uucp guest nobody lpd lp snapp ipsec nuucp pconsole invscout esaadmin sshd ]"
want_users=""

# you can put def at above,
# by the way, you can overwrite anytime when you run this pgm with parameters.
if [ -n "$*" ]; then
	want_users="$*"
fi

timestamp=`date +"%Y%m%d%H%M%S"`
logfile1="/home/se/safechk/safelog/${ApName}.${hostname}.last.$timestamp.txt"
logfile2="/home/se/safechk/safelog/${ApName}.${hostname}.expire.$timestamp.txt"
tmpfile="/tmp/${ApName}.tmp"
mon_dd=`date +"%b %d"`	# Mar 29
mm_dd=`date +"%m/%d"`	# 03/29
now_tt=`/usr/bin/perl -e 'print time'`
yt1=`/usr/bin/perl -e 'use POSIX qw(strftime);$str = strftime( "%b %m %d", localtime(time-86400));print $str'`
y_mon_dd=`echo $yt1 | awk '{printf("%s %s", $1, $3)}'`
y_mm_dd=`echo $yt1 | awk '{printf("%s/%s", $2, $3)}'`


#-----------------------------------------------------------------------------#
# covert tick to dd_HH_MM
# input parmeter: tick_time
# output: by echo like "xx days xx hours xx min"
# return 0=ok, 1=fail
# usage: tt2ddhh 1234567890
# 2012/04/06 prototype by paul
#-----------------------------------------------------------------------------#
tt2ddhh() {
	if [ -n "$1" ]; then
		tt=$1

		dd=`expr $tt / 86400`
		if [ $dd -gt 0 ]; then
			ans="$dd days"
			tt=`expr $tt % 86400`
		fi

		hh=`expr $tt / 3600`
		if [ $hh -gt 0 ]; then
			ans="$ans $hh hours"
			tt=`expr $tt % 3600`
		fi

		mm=`expr $tt / 60`
		if [ $mm -gt 0 ]; then
			ans="$ans $mm min."
			tt=`expr $tt % 60`
		fi
		echo $ans
		return 0;
	else
		return 1;
	fi
}

#-----------------------------------------------------------------------------#
# generate header in logfile
# input parmeter: logfilename , sub_title_string
# return 0=ok, 1=fail
# usage: logHdr logfilename sub_title_string
# 2012/04/06 prototype by paul
#-----------------------------------------------------------------------------#
logHdr() {
	# echo " * logHdr: args = [$0] , [$1] , [$2] , [$3] ,"
	if [ -n "$1" ]; then
		logfile=$1
		dt=`date +"%y/%m/%d %H:%M:%S"`
		echo "" >> $logfile
		echo "App: $ApName v${ApVers} @ $hostname" >> $logfile
		echo "Now: $dt" >> $logfile
		# echo "Target(Yesterday): $y_mon_dd , $y_mm_dd" >> $logfile

		if [ -n "$2" ]; then
			echo "" >> $logfile
			echo "$2" >> $logfile
			echo "" >> $logfile
		fi

		return 0;
	else
		return 1;
	fi
}

#-----------------------------------------------------------------------------#
# generate userlist by...
# 1. if exist want_users
# else
# 2. all users exclude skip_users
#
# pre-req: $want_users , $skip_users
# input parameter: none
# output: by echo
# usage: returnstr=`genUserList`
# 2012/04/06 prototype by paul
#-----------------------------------------------------------------------------#
genUserList() {
	if [ -n "$want_users" ]; then
		userlist0="$want_users"
	else
		userlist0=""
		alluser0=`lsuser ALL | awk '{print \$1}'`
		# echo "alluser0 = $alluser0"
		for auser0 in $alluser0
		do
			find0=`echo $skip_users | grep " $auser0 "`
			if [ ! -n "$find0" ]; then
				userlist0="$userlist0 $auser0"
			fi
		done
	fi
	# echo "userlist0 = $userlist0"
	echo "$userlist0"
	return 0
}

#-----------------------------------------------------------------------------#
# find lastest login record in /var/adm/wtmp of a user
# input parmeter: username
# output: by echo with user's record or null-str
# output-ex: root        pts/1       Apr 06 12:00     (10.10.1.41)
# usage: returnstr=`findLastLogin username`
# 2012/04/06 prototype by paul
#-----------------------------------------------------------------------------#
findLastLogin() {
	if [ -n "$1" ]; then
		username=$1

		# other ref:
		# > lsuser -a time_last_login root | grep '=' | sed 's/^.*=//'
		# root time_last_login=1333731616

		cmd1="who /var/adm/wtmp | awk '\$1~/^'${username}'/{dat=\$0}END{print dat}"
		# echo "CMD: $cmd1"
		eval $cmd1

		return 0;
	else
		return 1;
	fi
}

#-----------------------------------------------------------------------------#
# > pwdadm -q root
# root:
#         lastupdate = 1330894179
# 
# > lsuser -a maxage root
# root maxage=0
# exceed/overdue
#-----------------------------------------------------------------------------#
findPwLeftTime() {
	if [ -n "$1" ]; then
		username=$1
		maxAge=`lsuser -a maxage $username | grep '=' | sed 's/^.*=//'`

		### following lines for debug purpose ###
		# if [ $username = 'db2inst1' ]; then
		# 	maxAge=3
		# fi

		if [ ! -n "$maxAge" ]; then
			echo "unknown expire!"
		else
			if [ "$maxAge" = '0' ]; then
				echo "never expire!"
			else
				# echo "will expire in $maxAge weeks!"

				lastUpdate=`pwdadm -q $username | grep lastupdate | sed 's/^.*= //'`

				if [ ! -n "$lastUpdate" ] || [ "$lastUpdate" = '0' ]; then
					echo "unknown expire!"
				else
					# 一天有 86400 秒，乘以 7 得到 604800。所以一周有 604800 秒。
					leftAge=`expr 604800 \* $maxAge`
					nextExpire=`expr $lastUpdate + $leftAge`
					# echo $nextExpire
					leftExpire=`expr $now_tt - $nextExpire`
					if [ $leftExpire -ge 0 ]; then
						left_exceed="exceed"
					else
						left_exceed="left"
						leftExpire=`expr $leftExpire \* -1`
					fi
					leftDayHour=`tt2ddhh $leftExpire`
					echo "expire $left_exceed $leftDayHour"
				fi
			fi
		fi
		return 0;
	else
		return 1;
	fi
}

#-----------------------------------------------------------------------------#
# main func
# 2012/04/06 prototype by paul
#-----------------------------------------------------------------------------#
main() {
	#------------------------------
	# step 1/3: prepare target user list
	#------------------------------

	# echo "genUserList..."
	userlist=`genUserList`
	# echo "ulist = $ulist"

	let num=0
	for user1 in $userlist
	do
		let num=${num}+1
	done

	#------------------------------
	# step 2/3: find lastest login record of users
	#------------------------------

	logHdr $logfile1 "SUBJECT: lastest login of users"
	# echo " exc logHdr , rc = $? ,"

	let cnt=0
	for user1 in $userlist
	do
		let cnt=${cnt}+1
		findstr=`findLastLogin $user1`
		if [ -n "$findstr" ]; then
			echo "(${cnt}/${num}) $findstr" >> $logfile1
		else
			echo "(${cnt}/${num}) $user1   (nofound!)" >> $logfile1
		fi
	done

	#------------------------------
	# step 3/3: find expire time of users
	#------------------------------

	logHdr $logfile2 "SUBJECT: expire time of users"

	let cnt=0
	for user1 in $userlist
	do
		let cnt=${cnt}+1
		findstr=`findPwLeftTime $user1`
		echo "(${cnt}/${num}) $user1 $findstr" >> $logfile2
	done
}

main

