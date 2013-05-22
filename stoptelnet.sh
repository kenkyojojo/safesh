#! /usr/bin/ksh

#  Stop telnet service --- stop telnet on a list of hosts
#
#  You will need to adjust HOSTLIST, OWNER, PERMIT.  You may need to adjust DELAY
#

#----------------------------------
# Section 0 --- Set variable
#----------------------------------
HOSTLIST=`cat /home/se/safechk/cfg/host.lst`
#HOSTLIST=$1
USER=$(whoami)
HOMEDIR=`lsuser $USER | awk '{print $5}' | cut -c6-`
DELAY=1
exec 4>&1

#----------------------------------
# Section 1 --- Stop telnet service
#----------------------------------
for HOST in $HOSTLIST ; do
    ssh -p 2222 -t -t $HOST >&4 2>/dev/null |&
    print -p swrole SecPolicy,sa
    print -p stopsrc -t telnet
    print -p CHK=\`lssrc -t telnet \| grep inoperative \|awk \'{print \$2}\' \`
    print -p "test \$CHK == inoperative && touch stoptelnet.${HOST}"
    print -p exit
    print -p exit
    wait
done

#----------------------------------
# Section 2 --- Verify Service
#    Part 1 --- Retrieve those check files
#----------------------------------
for HOST in $HOSTLIST ; do
    #sftp ${USER}@${HOST} >&4 2>&4 |&
    #print -p lcd /tmp
    #print -p get stoptelnet.${HOST}
    #print -p rm stoptelnet.${HOST}
    #print -p bye
    #wait
    scp -P 2222 ${USER}@${HOST}:$HOMEDIR/stoptelnet.${HOST} /tmp/
    ssh -p 2222 ${USER}@${HOST} "rm -f $HOMEDIR/stoptelnet.${HOST}"
done

#----------------------------------
# Section 2 --- Verify Service
#    Part 2 --- Inspect the retrieved files
#----------------------------------
errors=0
echo
echo "#============================#"
echo "#  關閉Telnet主機結果清單:   #"
echo "#============================#"
for HOST in $HOSTLIST ; do
    if [[ -f /tmp/stoptelnet.${HOST} ]] ; then
        rm /tmp/stoptelnet.${HOST}
        echo $HOST OK!
    else
        echo $HOST has a problem!
        ((errors=errors+1))
    fi
done
((errors)) && exit 1


exit 0
