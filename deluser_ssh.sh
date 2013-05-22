#! /usr/bin/ksh

#  Delete user --- delete user on a list of hosts
#
#  You will need to adjust HOSTLIST.  You may need to adjust DELAY
#

if [ $# -lt 1 ]; then
    echo "Please Input deluser_ssh.sh username"
    echo
    echo "Example: deluser_ssh.sh se01"
    exit 1
fi

#----------------------------------
# Section 0 --- Set variable
#----------------------------------
HOSTLIST=`cat /home/se/safechk/cfg/host.lst`
UNAME=$1
MUSER=$(whoami)
HOMEDIR=`lsuser $MUSER | awk '{print $5}' | cut -c6-`
DELAY=1
exec 4>&1

#----------------------------------
# Section 1 --- Delete user
#----------------------------------
for HOST in $HOSTLIST ; do
    ssh -p 2222 -t -t $HOST >&4 2>/dev/null |&
    print -p swrole SecPolicy,sa
    print -p rmuser -p $UNAME
    print -p CHK=\`cut -f \"1\" -d : /etc/passwd \| grep "^$UNAME"\`
    print -p "test \"\$CHK\" != $UNAME && touch delusrdatafile.${HOST}"
    print -p exit
    print -p exit
    wait
done

#----------------------------------
# Section 2 --- Verify that user were deleted
#    Part 1 --- Retrieve those check files
#----------------------------------
for HOST in $HOSTLIST ; do
    #sftp ${MUSER}@${HOST} >&4 2>&4 |&
    #print -p lcd /tmp
    #print -p get delusrdatafile.${HOST}
    #print -p rm delusrdatafile.${HOST}
    #print -p bye
    #wait
    echo "$HOST 結果檢查中..."
    scp -P 2222 ${MUSER}@${HOST}:$HOMEDIR/delusrdatafile.${HOST} /tmp/
    ssh -p 2222 ${MUSER}@${HOST} "rm -f $HOMEDIR/delusrdatafile.${HOST}"
done

#----------------------------------
# Section 2 --- Verify that user were deleted
#    Part 2 --- Inspect the retrieved files
#----------------------------------
errors=0
echo
echo "#================================#"
echo "#  刪除使用者帳號主機結果清單:   #"
echo "#================================#"
for HOST in $HOSTLIST ; do
    if [[ -f /tmp/delusrdatafile.${HOST} ]] ; then
        rm /tmp/delusrdatafile.${HOST}
        echo $HOST OK!
    else
        echo $HOST has a problem!
        ((errors=errors+1))
    fi
done
((errors)) && exit 1


exit 0
