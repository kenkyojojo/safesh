#!/bin/ksh 
#
# safelog.sh
# collect sys-log about "who"
#
# History:
# 2012/03/29 1.0a Prototype.
# 2012/03/30 1.1a get yesterday-history.
#
#
#----------------------------------
# Set variable
#----------------------------------
ApName="safelog"
ApVers="1.1a"
hostname=`hostname`

# skip users when doing history cmd, please keep pre-,post-blank space!
skip_users="[ daemon bin sys adm uucp guest nobody lpd lp snapp ipsec nuucp pconsole invscout esaadmin sshd ]"

timestamp=`date +"%Y%m%d%H%M%S"`
logfile1="/home/se/safechk/safelog/safelog.${hostname}.wtmp.$timestamp.txt"
logfile2="/home/se/safechk/safelog/safelog.${hostname}.sulog.$timestamp.txt"
logfile3="/home/se/safechk/safelog/safelog.${hostname}.history.$timestamp.txt"
tmpfile="/tmp/safelog.tmp"
mon_dd=`date +"%b %d"`	# Mar 29
mm_dd=`date +"%m/%d"`	# 03/29
yt1=`/usr/bin/perl -e 'use POSIX qw(strftime);$str = strftime( "%b %m %d", localtime(time-86400));print $str'`
y_mon_dd=`echo $yt1 | awk '{printf("%s %s", $1, $3)}'`
y_mm_dd=`echo $yt1 | awk '{printf("%s/%s", $2, $3)}'`


#----------------------------------
# step 1/3: who /var/adm/wtmp
#----------------------------------

dt=`date +"%y/%m/%d %H:%M:%S"`
echo "" >> $logfile1
echo "App: $ApName v${ApVers} @ $hostname" >> $logfile1
echo "Now: $dt" >> $logfile1
echo "Target(Yesterday): $y_mon_dd , $y_mm_dd" >> $logfile1

echo "" >> $logfile1
cmd1="who /var/adm/wtmp | grep '$y_mon_dd'"
echo "CMD: $cmd1" >> $logfile1
eval $cmd1 >> $logfile1

#----------------------------------
# step 2/3: cat /var/adm/sulog
#----------------------------------

dt=`date +"%y/%m/%d %H:%M:%S"`
echo "" >> $logfile2
echo "App: $ApName v${ApVers} @ $hostname" >> $logfile2
echo "Now: $dt" >> $logfile2
echo "Target(Yesterday): $y_mon_dd , $y_mm_dd" >> $logfile2

echo "" >> $logfile2
cmd2="cat /var/adm/sulog | grep '$y_mm_dd' | grep -v '04:'"
echo "CMD: $cmd2" >> $logfile2
eval $cmd2 >> $logfile2

#----------------------------------
# step 3/3: history -t
#----------------------------------

dt=`date +"%y/%m/%d %H:%M:%S"`
echo "" >> $logfile3
echo "App: $ApName v${ApVers} @ $hostname" >> $logfile3
echo "Now: $dt" >> $logfile3
echo "Target(Yesterday): $y_mon_dd , $y_mm_dd" >> $logfile3

allusers=`lsuser ALL | awk '{print $1}'`
# echo "allusers = $allusers" >> $logfile3

# counter all-users
let num=0
for user1 in $allusers
do
	let num=$num+1
done

# loop do all-users
let cnt=0
for user1 in $allusers
do
	let cnt=$cnt+1

	# `su - $user1 "-c whoami > /dev/null"`
	# if [ $? -eq 0 ] ; then

	# nf4=`lsuser -c -a id home shell $user1 | awk -F: '$1!~/^#/{print NF}'`
	# let i4=$nf4
	# if [ $i4 -eq 4 ] ; then

	finduserx=`echo $skip_users | grep " $user1 "`
	# echo "finduserx=$finduserx"  # find=skip, nofound!=skip
	if [ ! -n "$finduserx" ]; then
		
		echo "" >> $logfile3
		# echo "(${cnt}/${num}) history of $user1 :"
		echo "(${cnt}/${num}) history of $user1 :" >> $logfile3
                  
		#su - $user1 "-c fc -t -2000 > $tmpfile"
		su - $user1 "-c fc -t -5000 > $tmpfile"
		cat $tmpfile | grep $y_mm_dd >> $logfile3
		rm $tmpfile
	else
		echo "" >> $logfile3
		# echo "(${cnt}/${num}) history of $user1 : skip"
		echo "(${cnt}/${num}) history of $user1 : skip" >> $logfile3
	fi
done



/home/se/safechk/safesh/lastlogin.sh
/home/se/safechk/safesh/faillogin.sh
/home/se/safechk/safesh/pwlog.sh
