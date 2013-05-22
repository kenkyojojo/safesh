#! /usr/bin/ksh

#  Stop ssh --- Stop ssh on a list of hosts
#
#  You will need to adjust HOSTLIST, OWNER, PERMIT.  You may need to adjust DELAY
#

if [ $# -lt 1 ]; then
    echo "Please Input stopsshd.sh hostname"
    echo
    echo "Example: stopsshd.sh log1"
    exit 1
fi

#----------------------------------
# Section 0 --- Set variable
#----------------------------------
HOSTLIST=$1
USER=$(whoami)
DELAY=1
stty -echo
print 
print -n Please Enter $USER Password-
read OLDPASS
print 
stty echo
exec 4>&1

#----------------------------------
# Section 1 --- Stop SSH service
#----------------------------------
for HOST in $HOSTLIST ; do
    ssh -p 2222 -t -t $HOST >&4 2>/dev/null |&
    print -p stopsrc -s sshd
    print -p CHK=\`lssrc -a \| grep sshd \| grep inoperative \|awk \'{print \$3}\' \`
    print -p "test \$CHK == inoperative && touch stopsshdfile.${HOST}"
    print -p exit
    print -p exit
    wait
done

#----------------------------------
# Section 2 --- Verify SSH Service
#    Part 1 --- Retrieve those files via ftp again
#----------------------------------
ftp -nv >&4 2>&4 |&
for HOST in $HOSTLIST ; do
    print -p open $HOST
    print -p user $USER $OLDPASS
    print -p lcd /tmp
    print -p copy 
    print -p get stopsshdfile.${HOST}
    print -p delete stopsshdfile.${HOST}
    print -p close
done
print -p bye
wait

#----------------------------------
# Section 2 --- Verify SSH Service
#    Part 2 --- Inspect the retrieved files
#----------------------------------
errors=0
echo
echo "--------------------------------"
echo "Stop SSH Service on following machines:"
for HOST in $HOSTLIST ; do
    if [[ -f /tmp/stopsshdfile.${HOST} ]] ; then
        rm /tmp/stopsshdfile.${HOST}
        echo $HOST OK!
    else
        echo $HOST has a problem!
        ((errors=errors+1))
    fi
done
((errors)) && exit 1


exit 0
