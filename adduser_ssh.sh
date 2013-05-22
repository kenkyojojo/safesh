#! /usr/bin/ksh

#  Create user --- create user on a list of hosts
#
#  You will need to adjust HOSTLIST.  You may need to adjust DELAY
#

if [ $# -lt 5 ]; then
    echo "Please Input adduser_ssh.sh Pgroupname Groupname umask userid username"
    echo
    echo "Example: adduser_ssh.sh se se 002 303 se01"
    exit 1
fi

#----------------------------------
# Section 0 --- Set variable
#----------------------------------
HOSTLIST=`cat /home/se/safechk/cfg/host.lst`
PGROUP=$1
GROUP=$2
UMASK=$3
UID=$4
UNAME=$5
loginretries="10"
pwdwarntime="7"
histsize="6"
maxexpired="1"
minlen="7"
if [ "$UNAME" == "twse" ]; then
   maxage="12"
else
   maxage="7"
fi
NEWPASS="1234567"
MUSER=$(whoami)
HOMEDIR=`lsuser $MUSER | awk '{print $5}' | cut -c6-`
DELAY=1
exec 4>&1

#----------------------------------
# Section 1 --- Create User
#----------------------------------
for HOST in $HOSTLIST ; do
    ssh -p 2222 -t -t $HOST >&4 2>/dev/null |&
    #sleep $DELAY
    print -p swrole SecPolicy,sa
    print -p mkuser pgrp=$PGROUP groups=$GROUP home="/home/$PGROUP/"$UNAME shell='/usr/bin/ksh' umask=$UMASK id=$UID loginretries="$loginretries" pwdwarntime="$pwdwarntime" histsize="$histsize" maxexpired="$maxexpired" maxage="$maxage" minlen="$minlen" $5
    print -p "echo \"$UNAME:$NEWPASS\"|chpasswd"
    print -p pwdadm -c $UNAME
    print -p CHK=\`cut -f \"1\" -d : /etc/passwd \| grep "^$UNAME"\`
    print -p "test \$CHK == $UNAME && touch addusrdatafile.${HOST}"
    print -p exit
    print -p exit
    wait
done

#----------------------------------
# Section 2 --- Verify that the user were created
#    Part 1 --- Retrieve those check files
#----------------------------------
for HOST in $HOSTLIST ; do
    #sftp ${MUSER}@${HOST} >&4 2>&4 |&
    #print -p lcd /tmp
    #print -p get addusrdatafile.${HOST}
    #print -p rm addusrdatafile.${HOST}
    #print -p bye
    #wait
    echo "$HOST 結果檢查中..."
    scp -P 2222 ${MUSER}@${HOST}:$HOMEDIR/addusrdatafile.${HOST} /tmp/
    ssh -p 2222 ${MUSER}@${HOST} "rm -f $HOMEDIR/addusrdatafile.${HOST}"
done

#----------------------------------
# Section 2 --- Verify that the user were created
#    Part 2 --- Inspect the retrieved files
#----------------------------------
errors=0
echo
echo "#================================#"
echo "#  新增使用者帳號主機結果清單:   #"
echo "#================================#"
for HOST in $HOSTLIST ; do
    if [[ -f /tmp/addusrdatafile.${HOST} ]] ; then
        rm /tmp/addusrdatafile.${HOST}
        echo $HOST OK!
    else
        echo $HOST has a problem!
        ((errors=errors+1))
    fi
done
((errors)) && exit 1


exit 0
