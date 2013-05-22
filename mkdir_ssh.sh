#! /usr/bin/ksh

#  Create directory --- create directory on a list of hosts
#
#  You will need to adjust HOSTLIST, OWNER, PERMIT.  You may need to adjust DELAY
#

if [ $# -lt 3 ]; then
    echo "Please Input mkdir_ssh.sh Owner:Group Directory Permission"
    echo
    echo "Example: mkdir_ssh.sh useradm:security /home/se/test 755"
    exit 1
fi

#----------------------------------
# Section 0 --- Set variable
#----------------------------------
HOSTLIST=`cat /home/se/safechk/cfg/host.lst`
OWNER=$1
DIR=$2
PERMIT=$3
USER=$(whoami)
HOMEDIR=`lsuser $USER | awk '{print $5}' | cut -c6-`
DELAY=1
exec 4>&1

#----------------------------------
# Section 1 --- Create Directory
#----------------------------------
for HOST in $HOSTLIST ; do
    ssh -p 2222 -t -t $HOST >&4 2>/dev/null |&
    print -p swrole SecPolicy,sa
    print -p mkdir -p $DIR
    print -p chown $OWNER $DIR
    print -p chmod $PERMIT $DIR
    print -p "test -d $DIR && touch mkdirdatafile.${HOST}"
    print -p exit
    print -p exit
    wait
done

#----------------------------------
# Section 2 --- Verify that the directory were created
#    Part 1 --- Retrieve those check files
#----------------------------------
for HOST in $HOSTLIST ; do
    #sftp ${USER}@${HOST} >&4 2>&4 |&
    #print -p lcd /tmp
    #print -p get mkdirdatafile.${HOST}
    #print -p rm mkdirdatafile.${HOST}
    #print -p bye
    #wait
    echo "$HOST 結果檢查中..."
    scp -P 2222 ${USER}@${HOST}:$HOMEDIR/mkdirdatafile.${HOST} /tmp/
    ssh -p 2222 ${USER}@${HOST} "rm -f $HOMEDIR/mkdirdatafile.${HOST}"
done

#----------------------------------
# Section 2 --- Verify that the directory were created
#    Part 2 --- Inspect the retrieved files
#----------------------------------
errors=0
echo
echo "#==========================#"
echo "#  新增目錄主機結果清單:   #"
echo "#==========================#"
for HOST in $HOSTLIST ; do
    if [[ -f /tmp/mkdirdatafile.${HOST} ]] ; then
        rm /tmp/mkdirdatafile.${HOST}
        echo $HOST OK!
    else
        echo $HOST has a problem!
        ((errors=errors+1))
    fi
done
((errors)) && exit 1


exit 0
