#! /usr/bin/ksh

#  Delete directory --- delete directory on a list of hosts
#
#  You will need to adjust HOSTLIST.   You may need to adjust DELAY
#

if [ $# -lt 1 ]; then
    echo "Please Input rmdir_ssh.sh Directory"
    echo
    echo "Example: rmdir_ssh.sh /home/se/test"
    exit 1
fi


#----------------------------------
# Section 0 --- Set variable
#----------------------------------
DIR=$1
USER=$(whoami)
HOMEDIR=`lsuser $USER | awk '{print $5}' | cut -c6-`
DELAY=1
HOSTNAME=$(hostname)

if [[ $USER != "root" ||  $USER != "useradm" ]] ; then
	echo "The $USER permission deny,Please to check the login User. Ex:root or useradm"
	exit 1
fi

#----------------------------------
# Section 1 --- Delete Directory
#----------------------------------
HOSTLIST=`cat /home/se/safechk/cfg/host.lst`
exec 4>&1
if [[ $USER = "root" ]] ; then
		for HOST in $HOSTLIST ; do
			ssh -p 2222 -t -t $HOST >&4 2>/dev/null |&
			print -p rm -rf $DIR
			print -p "test -d $DIR || touch /tmp/rmdirdatafile.${HOST}"
			print -p exit
			print -p exit
			wait
		done
else
		for HOST in $HOSTLIST ; do
			ssh -p 2222 -t -t $HOST >&4 2>/dev/null |&
			print -p swrole SecPolicy,sa
			print -p rm -rf $DIR
			print -p "test -d $DIR || touch /tmp/rmdirdatafile.${HOST}"
			print -p exit
			print -p exit
			wait
		done
fi

#----------------------------------
# Section 2 --- Verify that the directory were deleted
#    Part 1 --- Retrieve those check files
#----------------------------------
HOSTLIST=`cat /home/se/safechk/cfg/host.lst | grep -v WKL`
for HOST in $HOSTLIST ; do
    #sftp ${USER}@${HOST} >&4 2>&4 |&
    #print -p lcd /tmp
    #print -p get rmdirdatafile.${HOST}
    #print -p rm rmdirdatafile.${HOST}
    #print -p bye
    #wait
    echo "$HOST 結果檢查中..."
    scp -P 2222 ${USER}@${HOST}:$HOMEDIR/rmdirdatafile.${HOST} /tmp/
    ssh -p 2222 ${USER}@${HOST} "rm -f $HOMEDIR/rmdirdatafile.${HOST}"
done

#----------------------------------
# Section 2 --- Verify that the directory were deleted
#    Part 2 --- Inspect the retrieved files
#----------------------------------
HOSTLIST=`cat /home/se/safechk/cfg/host.lst`
errors=0
echo
echo "#==========================#"
echo "#  刪除目錄主機結果清單:   #"
echo "#==========================#"
for HOST in $HOSTLIST ; do
    if [[ -f /tmp/rmdirdatafile.${HOST} ]] ; then
        rm /tmp/rmdirdatafile.${HOST}
        echo $HOST OK!
    else
        echo $HOST has a problem!
        ((errors=errors+1))
    fi
done
((errors)) && exit 1


exit 0
