#! /usr/bin/ksh

#  Unlock user --- unlock user on a list of hosts
#
#  You will need to adjust HOSTLIST.  You may need to adjust DELAY
#

if [ $# -lt 2 ]; then
    echo "Please Input usrlock_ssh.sh Username DefaultPassword"
    echo
    echo "Example: usrlock_ssh.sh useradm 1234567"
    exit 1
fi

#----------------------------------
# Section 0 --- Set variable
#----------------------------------
USER=$1
NEWPASS=$2
MUSER=$(whoami)
HOMEDIR=`lsuser $MUSER | awk '{print $5}' | cut -c6-`
DELAY=1

if [[ $MUSER != "root" &&  $MUSER != "useradm" ]] ; then
	echo "The $MUSER permission deny,Please to check the login User. Ex:root or useradm"
	exit 1
fi

#----------------------------------
# Section 1 --- Unlock User
#----------------------------------
HOSTLIST=`cat /home/se/safechk/cfg/host.lst`
exec 4>&1
if [[ $MUSER = "root" ]] ; then
		for HOST in $HOSTLIST ; do
			ssh -p 2222 -t -t $HOST >&4 2>/dev/null |&
			#sleep $DELAY
			print -p chsec -f /etc/security/lastlog -a "unsuccessful_login_count=0" -s $USER
			print -p chuser "account_locked=false" $USER
			print -p "echo \"$USER:$NEWPASS\"|chpasswd"
			print -p pwdadm -c $USER
			print -p CHK=`lssec -f /etc/security/lastlog -a "unsuccessful_login_count" -s $USER | awk '{print $2}' | awk -F= '{print $2}'`
			print -p "test \$CHK == 0 && touch /tmp/unlockdatafile.${HOST}"
			print -p exit
			print -p exit
			wait
		done
else
		for HOST in $HOSTLIST ; do
			ssh -p 2222 -t -t $HOST >&4 2>/dev/null |&
			#sleep $DELAY
			print -p swrole SecPolicy,sa
			print -p chsec -f /etc/security/lastlog -a "unsuccessful_login_count=0" -s $USER
			print -p chuser "account_locked=false" $USER
			print -p "echo \"$USER:$NEWPASS\"|chpasswd"
			print -p pwdadm -c $USER
			print -p CHK=`lssec -f /etc/security/lastlog -a "unsuccessful_login_count" -s $USER | awk '{print $2}' | awk -F= '{print $2}'`
			print -p "test \$CHK == 0 && touch /tmp/unlockdatafile.${HOST}"
			print -p exit
			print -p exit
			wait
		done
fi

#----------------------------------
# Section 2 --- Verify user unlock
#    Part 1 --- Retrieve those check files
#----------------------------------
HOSTLIST=`cat /home/se/safechk/cfg/host.lst|grep -v WKL`
for HOST in $HOSTLIST ; do
    #sftp ${MUSER}@${HOST} >&4 2>&4 |&
    #print -p lcd /tmp
    #print -p get unlockdatafile.${HOST}
    #print -p rm unlockdatafile.${HOST}
    #print -p bye
    #wait
    echo "$HOST 結果檢查中..."
    scp -P 2222 ${MUSER}@${HOST}:/tmp/unlockdatafile.${HOST} /tmp/
    ssh -p 2222 ${MUSER}@${HOST} "rm -f /tmp/unlockdatafile.${HOST}"
done

#----------------------------------
# Section 2 --- Verify user unlock
#    Part 2 --- Inspect the retrieved files
#----------------------------------
HOSTLIST=`cat /home/se/safechk/cfg/host.lst`
errors=0
echo
echo "#================================#"
echo "#  解鎖使用者帳號主機結果清單:   #"
echo "#================================#"
for HOST in $HOSTLIST ; do
    if [[ -f /tmp/unlockdatafile.${HOST} ]] ; then
        rm /tmp/unlockdatafile.${HOST}
        echo $HOST OK!
    else
        echo $HOST has a problem!
        ((errors=errors+1))
    fi
done
((errors)) && exit 1


exit 0
