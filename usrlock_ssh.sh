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
HOSTLIST=`cat /home/se/safechk/cfg/host.lst`
USER=$1
NEWPASS=$2
MUSER=$(whoami)
HOMEDIR=`lsuser $MUSER | awk '{print $5}' | cut -c6-`
DELAY=1
exec 4>&1

#----------------------------------
# Section 1 --- Unlock User
#----------------------------------
for HOST in $HOSTLIST ; do
    ssh -p 2222 -t -t $HOST >&4 2>/dev/null |&
    #sleep $DELAY
    print -p swrole SecPolicy,sa
    print -p chsec -f /etc/security/lastlog -a "unsuccessful_login_count=0" -s $USER
    print -p chuser "account_locked=false" $USER
    print -p "echo \"$USER:$NEWPASS\"|chpasswd"
    print -p pwdadm -c $USER
    print -p CHK=`lssec -f /etc/security/lastlog -a "unsuccessful_login_count" -s $USER | awk '{print $2}' | awk -F= '{print $2}'`
    print -p "test \$CHK == 0 && touch $HOMEDIR/unlockdatafile.${HOST}"
    print -p exit
    print -p exit
    wait
done

#----------------------------------
# Section 2 --- Verify user unlock
#    Part 1 --- Retrieve those check files
#----------------------------------
for HOST in $HOSTLIST ; do
    #sftp ${MUSER}@${HOST} >&4 2>&4 |&
    #print -p lcd /tmp
    #print -p get unlockdatafile.${HOST}
    #print -p rm unlockdatafile.${HOST}
    #print -p bye
    #wait
    echo "$HOST 結果檢查中..."
    scp -P 2222 ${MUSER}@${HOST}:$HOMEDIR/unlockdatafile.${HOST} /tmp/
    ssh -p 2222 ${MUSER}@${HOST} "rm -f $HOMEDIR/unlockdatafile.${HOST}"
done

#----------------------------------
# Section 2 --- Verify user unlock
#    Part 2 --- Inspect the retrieved files
#----------------------------------
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
