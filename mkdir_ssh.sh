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
OWNER=$1
DIR=$2
PERMIT=$3
USER=$(whoami)
HOMEDIR=`lsuser $USER | awk '{print $5}' | cut -c6-`
DELAY=1
HOSTNAME=$(hostname)

if [[ $USER != "root" ||  $USER != "useradm" ]] ; then
	echo "The $USER permission deny,Please to check the login User. Ex:root or useradm"
	exit 1
fi

#----------------------------------
# Section 1 --- Create Directory
#----------------------------------
HOSTLIST=`cat /home/se/safechk/cfg/host.lst`
exec 4>&1
if [[ $USER = "root" ]] ; then
		for HOST in $HOSTLIST ; do
			ssh -p 2222 -t -t $HOST >&4 2>/dev/null |&
			print -p mkdir -p $DIR
			print -p chown $OWNER $DIR
			print -p chmod $PERMIT $DIR
			print -p "test -d $DIR && touch /tmp/mkdirdatafile.${HOST}"
			print -p exit
			print -p exit
			wait
		done
else 
		for HOST in $HOSTLIST ; do
			ssh -p 2222 -t -t $HOST >&4 2>/dev/null |&
			print -p swrole SecPolicy,sa
			print -p mkdir -p $DIR
			print -p chown $OWNER $DIR
			print -p chmod $PERMIT $DIR
			print -p "test -d $DIR && touch /tmp/mkdirdatafile.${HOST}"
			print -p exit
			print -p exit
			wait
		done
fi

#----------------------------------
# Section 2 --- Verify that the directory were created
#    Part 1 --- Retrieve those check files
#----------------------------------
HOSTLIST=`cat /home/se/safechk/cfg/host.lst | grep -v WKL`
for HOST in $HOSTLIST ; do
    #sftp ${USER}@${HOST} >&4 2>&4 |&
    #print -p lcd /tmp
    #print -p get mkdirdatafile.${HOST}
    #print -p rm mkdirdatafile.${HOST}
    #print -p bye
    #wait
    echo "$HOST 結果檢查中..."
    scp -P 2222 ${USER}@${HOST}:/tmp/mkdirdatafile.${HOST} /tmp/
    ssh -p 2222 ${USER}@${HOST} "rm -f /tmp/mkdirdatafile.${HOST}"
done

#----------------------------------
# Section 2 --- Verify that the directory were created
#    Part 2 --- Inspect the retrieved files
#----------------------------------
HOSTLIST=`cat /home/se/safechk/cfg/host.lst`
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
