#! /usr/bin/ksh

#  Unlock user --- unlock user on a list of hosts
#
#  You will need to adjust HOSTLIST.  You may need to adjust DELAY
#

if [ $# -lt 2 ]; then
    echo "Please Input usrlock_telnet.sh Username DefaultPassword"
    echo
    echo "Example: usrlock_telnet.sh useradm 1234567"
    exit 1
fi

#----------------------------------
# Section 0 --- Set variable
#----------------------------------
HOSTLIST=`cat /home/se/safechk/cfg/host.lst`
USER=$1
NEWPASS=$2
MUSER=$(whoami)
DELAY=1
stty -echo
print 
print -n Please Enter $MUSER Password-
read MUSERPASS
print 
stty echo
exec 4>&1

#----------------------------------
# Section 1 --- Unlock user
#----------------------------------
for HOST in $HOSTLIST ; do
    telnet $HOST >&4 2>&4 |&
    sleep $DELAY
    print -p $MUSER
    sleep $DELAY
    print -p $MUSERPASS
    sleep $DELAY
    print -p swrole SecPolicy,sa
    sleep $DELAY
    print -p chsec -f /etc/security/lastlog -a "unsuccessful_login_count=0" -s $USER
    sleep $DELAY
    print -p chuser "account_locked=false" $USER
    sleep $DELAY
    print -p "echo \"$USER:$NEWPASS\"|chpasswd"
    sleep $DELAY
    print -p pwdadm -c $USER
    sleep $DELAY
    print -p CHK=`lssec -f /etc/security/lastlog -a "unsuccessful_login_count" -s $USER | awk '{print $2}' | awk -F= '{print $2}'`
    sleep $DELAY
    print -p "test \$CHK == 0 && touch unlockdatafile.${HOST}"
    sleep $DELAY
    print -p exit
    sleep $DELAY
    print -p exit
    wait
done

#----------------------------------
# Section 2 --- Verify user unlock
#    Part 1 --- Retrieve those files via ftp again
#----------------------------------
ftp -nv >&4 2>&4 |&
for HOST in $HOSTLIST ; do
    print -p open $HOST
    print -p user $MUSER $NEWPASS
    print -p lcd /tmp
    print -p copy
    print -p get unlockdatafile.${HOST}
    print -p delete unlockdatafile.${HOST}
    print -p close
done
print -p bye
wait

#----------------------------------
# Section 2 --- Verify user unlock
#    Part 2 --- Inspect the retrieved files
#----------------------------------
errors=0
echo
echo "--------------------------------"
echo "Unlock user on following machines:"
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
