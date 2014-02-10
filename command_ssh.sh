#! /usr/bin/ksh

#  Excute command --- Excute command on a list of hosts
#
#  You will need to adjust HOSTLIST, OWNER, PERMIT.  You may need to adjust DELAY
#

if [ $# -lt 2 ]; then
    echo "Please Input command_ssh.sh Hostname Command"
    echo
    echo "Example: command_ssh.sh "dev1 dap1-1" "ls -l""
    exit 1
fi

#----------------------------------
# Section 0 --- Set variable
#----------------------------------
HOSTLIST=$1
command=$2
USER=$(whoami)
HOMEDIR=`lsuser $USER | awk '{print $5}' | cut -c6-`
DELAY=1

#----------------------------------
# Section 1 --- Excute command
#----------------------------------
exec 4>&1
for HOST in $HOSTLIST ; do
    ssh -p 2222 -t -t $HOST >&4 2>/dev/null |&
    print -p $command
    print -p CHK=$?
    print -p "test \$CHK == 0 && touch command.${HOST}"
    print -p exit
    print -p exit
    wait
done

#----------------------------------
# Section 2 --- Verify
#    Part 1 --- Retrieve those check files
#----------------------------------
for HOST in $HOSTLIST ; do
    #sftp ${USER}@${HOST} >&4 2>&4 |&
    #print -p lcd /tmp
    #print -p get command.${HOST}
    #print -p rm command.${HOST}
    #print -p bye
    #wait
    echo "$HOST 結果檢查中..."
    scp -P 2222 ${USER}@${HOST}:$HOMEDIR/command.${HOST} /tmp/
    ssh -p 2222 ${USER}@${HOST} "rm -f $HOMEDIR/command.${HOST}"
done

#----------------------------------
# Section 2 --- Verify
#    Part 2 --- Inspect the retrieved files
#----------------------------------
errors=0
echo
echo "--------------------------------"
echo "Excute command on following machines:"
for HOST in $HOSTLIST ; do
    if [[ -f /tmp/command.${HOST} ]] ; then
        rm /tmp/command.${HOST}
        echo $HOST OK!
    else
        echo $HOST has a problem!
        ((errors=errors+1))
    fi
done
((errors)) && exit 1


exit 0
