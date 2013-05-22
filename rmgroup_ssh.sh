#! /usr/bin/ksh

#  Delete group --- Delete group on a list of hosts
#
#  You will need to adjust HOSTLIST, OWNER, PERMIT.  You may need to adjust DELAY
#

if [ $# -lt 1 ]; then
    echo "Please Input rmgroup_ssh.sh GroupName"
    echo
    echo "Example: rmgroup_ssh.sh se"
    exit 1
fi

#----------------------------------
# Section 0 --- Set variable
#----------------------------------
HOSTLIST=`cat /home/se/safechk/cfg/host.lst`
GROUP=$1
USER=$(whoami)
HOMEDIR=`lsuser $USER | awk '{print $5}' | cut -c6-`
DELAY=1
exec 4>&1

#----------------------------------
# Section 1 --- Delete Group
#----------------------------------
for HOST in $HOSTLIST ; do
    ssh -p 2222 -t -t $HOST >&4 2>/dev/null |&
    print -p swrole SecPolicy,sa
    print -p rmgroup -p $GROUP
    print -p CHK=\`lsgroup -a ALL \| grep "^$GROUP$"\`
    print -p "test \"\$CHK\" != $GROUP && touch delgrpdatafile.${HOST}"
    print -p exit
    print -p exit
    wait
done

#----------------------------------
# Section 2 --- Verify Group
#    Part 1 --- Retrieve those check files
#----------------------------------
for HOST in $HOSTLIST ; do
    #sftp ${USER}@${HOST} >&4 2>&4 |&
    #print -p lcd /tmp
    #print -p get delgrpdatafile.${HOST}
    #print -p rm delgrpdatafile.${HOST}
    #print -p bye
    #wait
    echo "$HOST 結果檢查中..."
    scp -P 2222 ${USER}@${HOST}:$HOMEDIR/delgrpdatafile.${HOST} /tmp/
    ssh -p 2222 ${USER}@${HOST} "rm -f $HOMEDIR/delgrpdatafile.${HOST}"
done

#----------------------------------
# Section 2 --- Verify Group
#    Part 2 --- Inspect the retrieved files
#----------------------------------
errors=0
echo
echo "#==========================#"
echo "#  刪除群組主機結果清單:   #"
echo "#==========================#"
for HOST in $HOSTLIST ; do
    if [[ -f /tmp/delgrpdatafile.${HOST} ]] ; then
        rm /tmp/delgrpdatafile.${HOST}
        echo $HOST OK!
    else
        echo $HOST has a problem!
        ((errors=errors+1))
    fi
done
((errors)) && exit 1


exit 0
