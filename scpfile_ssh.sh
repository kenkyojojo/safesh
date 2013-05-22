#! /usr/bin/ksh

#  SCP file --- SCP file on a list of hosts
#
#  You will need to adjust HOSTLIST.  You may need to adjust DELAY
#

if [ $# -lt 3 ]; then
    echo "Please Input scpfile_ssh.sh LocalPath LocalFile RemoteDirPath"
    echo
    echo "Example: scpfile_ssh.sh /home/se test.txt /home/se01"
    exit 1
fi

#----------------------------------
# Section 0 --- Set variable
#----------------------------------
HOSTLIST=`cat /home/se/safechk/cfg/host.lst`
LDIRPATH=$1
LFILE=$2
RDIRPATH=$3
MUSER=$(whoami)
HOMEDIR=`lsuser $MUSER | awk '{print $5}' | cut -c6-`
DELAY=1
exec 4>&1

#----------------------------------
# Section 1 --- Scp file
#----------------------------------
for HOST in $HOSTLIST ; do
    ssh -p 2222 -t -t $HOST >&4 2>/dev/null |&
    print -p "test -e $RDIRPATH/$LFILE && touch scpdatafile.${HOST}"
    print -p exit
    wait
done

#----------------------------------
# Section 2 --- Verify
#    Part 1 --- Retrieve those check files
#----------------------------------
for HOST in $HOSTLIST ; do
    #sftp ${MUSER}@${HOST} >&4 2>&4 |&
    #print -p lcd /tmp
    #print -p get scpdatafile.${HOST}
    #print -p rm scpdatafile.${HOST}
    #print -p bye
    #wait
    echo "$HOST 結果檢查中..."
    scp -P 2222 ${MUSER}@${HOST}:$HOMEDIR/scpdatafile.${HOST} /tmp/
    ssh -p 2222 ${MUSER}@${HOST} "rm -f $HOMEDIR/scpdatafile.${HOST}"
done

#----------------------------------
# Section 2 --- Verify
#    Part 2 --- Inspect the retrieved files
#----------------------------------
errors=0
echo
echo "#==========================#"
echo "#  同步檔案主機結果清單:   #"
echo "#==========================#"
for HOST in $HOSTLIST ; do
    if [[ -f /tmp/scpdatafile.${HOST} ]] ; then
        rm /tmp/scpdatafile.${HOST}
        echo $HOST OK!
    else
        echo $HOST has a problem!
        ((errors=errors+1))
    fi
done
((errors)) && exit 1


exit 0
