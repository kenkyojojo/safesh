#! /usr/bin/ksh

#  Create group --- Create group on a list of hosts
#
#  You will need to adjust HOSTLIST, OWNER, PERMIT.  You may need to adjust DELAY
#

if [ $# -lt 2 ]; then
    echo "Please Input mkgroup_ssh.sh GroupID GroupName"
    echo
    echo "Example: mkgroup_ssh.sh 300 se"
    exit 1
fi

#----------------------------------
# Section 0 --- Set variable
#----------------------------------
HOSTLIST=`cat /home/se/safechk/cfg/host.lst`
GID=$1
GROUP=$2
USER=$(whoami)
HOMEDIR=`lsuser $USER | awk '{print $5}' | cut -c6-`
DELAY=1
exec 4>&1

#----------------------------------
# Section 1 --- Create Group
#----------------------------------
for HOST in $HOSTLIST ; do
    ssh -p 2222 -t -t $HOST >&4 2>/dev/null |&
    print -p swrole SecPolicy,sa
    print -p mkgroup -a id=$GID $GROUP
    print -p CHK=\`lsgroup -a ALL \| grep "^$GROUP$"\`
    print -p "test \$CHK == $GROUP && touch addgrpdatafile.${HOST}"
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
    #print -p get addgrpdatafile.${HOST}
    #print -p rm addgrpdatafile.${HOST}
    #print -p bye
    #wait
    echo "$HOST 結果檢查中..."
    scp -P 2222 ${USER}@${HOST}:$HOMEDIR/addgrpdatafile.${HOST} /tmp/
    ssh -p 2222 ${USER}@${HOST} "rm -f $HOMEDIR/addgrpdatafile.${HOST}"
done

#----------------------------------
# Section 2 --- Verify Group
#    Part 2 --- Inspect the retrieved files
#----------------------------------
errors=0
echo
echo "#==========================#"
echo "#  新增群組主機結果清單:   #"
echo "#==========================#"
for HOST in $HOSTLIST ; do
    if [[ -f /tmp/addgrpdatafile.${HOST} ]] ; then
        rm /tmp/addgrpdatafile.${HOST}
        echo $HOST OK!
    else
        echo $HOST has a problem!
        ((errors=errors+1))
    fi
done
((errors)) && exit 1


exit 0
