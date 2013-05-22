#! /usr/bin/ksh

#  Create directory --- create directory on a list of hosts
#
#  You will need to adjust HOSTLIST, OWNER, PERMIT.  You may need to adjust DELAY
#

if [ $# -lt 3 ]; then
    echo "Please Input mkdir.sh Owner:Group Directory Permission"
    echo
    echo "Example: mkdir.sh useradm:security /home/se/test 755"
    exit 1
fi

#----------------------------------
# Section 0 --- Set variable
#----------------------------------
HOSTLIST="cat /home/se/safechk/cfg/host.lst"
OWNER=$1
DIRLIST=$2
PERMIT=$3
USER=$(whoami)
DELAY=1
stty -echo
print -n Enter $USER Password-
read OLDPASS
print 
stty echo
exec 4>&1

#----------------------------------
# Section 1 --- Create Directory
#----------------------------------
for HOST in $HOSTLIST ; do
    echo $OWNER
    telnet $HOST >&4 2>&4 |&
    sleep $DELAY
    print -p $USER
    sleep $DELAY
    print -p $OLDPASS
    sleep $DELAY
    for DIR in $DIRLIST ; do
       print -p mkdir -p $DIR
       sleep $DELAY
       print -p chown $OWNER $DIR
       sleep $DELAY
       print -p chmod $PERMIT $DIR
       sleep $DELAY
       if [ -d $DIR ]; then
          print -p touch mkdirdatafile.${HOST}
          sleep $DELAY
       fi
    done
    print -p exit
    wait
done

#
#  Section 2 --- Verify that the directory were created
#     Part 1 --- Retrieve those files via ftp again

ftp -nv >&4 2>&4 |&
for HOST in $HOSTLIST ; do
    print -p open $HOST
    print -p user $USER $OLDPASS
    print -p lcd /tmp
    print -p copy
    print -p get mkdirdatafile.${HOST}
    print -p delete mkdirdatafile.${HOST}
    print -p close
done
print -p bye
wait

#
#  Section 2 --- Verify that the directory were created
#     Part 2 --- Inspect the retrieved files

errors=0
echo
echo "--------------------------------"
echo "Directory on following machines:"
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
