#! /usr/bin/ksh

#  changepass --- change the user's password on a list of hosts
#
#  You will need to adjust HOSTLIST.  You may need to adjust DELAY
#  and all of section 2.
#

#----------------------------------
# Section 0 --- Set variable
#----------------------------------
HOSTLIST=`cat /home/se/safechk/cfg/host.lst`
DELAY=1
stty -echo
print -n Enter Old Password-
read OLDPASS
print 
print -n Enter New Password-
read NEWPASS
print
stty echo
USER=$(whoami)
exec 4>&1

#----------------------------------
# Section 1 --- Change the passwords
#----------------------------------
for HOST in $HOSTLIST ; do
    telnet $HOST >&4 2>&4 |&
    sleep $DELAY
    print -p $USER
    sleep $DELAY
    print -p $OLDPASS
    sleep $DELAY
    print -p touch changepassdatafile.$HOST.$USER
    sleep $DELAY
    print -p passwd
    sleep $DELAY
    print -p $OLDPASS
    sleep $DELAY
    print -p $NEWPASS
    sleep $DELAY
    print -p $NEWPASS
    sleep $DELAY
    print -p exit
    wait
done

#----------------------------------
# Section 2 --- Verify that the passwords were changed
#    Part 1 --- Retrieve those files via ftp again
#----------------------------------
ftp -nv >&4 2>&4 |&
for HOST in $HOSTLIST ; do
    print -p open $HOST
    print -p user $USER $NEWPASS
    print -p lcd /tmp
    print -p get changepassdatafile.${HOST}.${USER}
    print -p delete changepassdatafile.${HOST}.${USER}
    print -p close
done
print -p bye
wait

#----------------------------------
# Section 2 --- Verify that the passwords were changed
#    Part 2 --- Inspect the retrieved files
#----------------------------------
errors=0
echo
echo "--------------------------------"
echo "Change $USER password on following machines:"
for HOST in $HOSTLIST ; do
    if [[ -f /tmp/changepassdatafile.${HOST}.${USER} ]] ; then
        rm /tmp/changepassdatafile.${HOST}.${USER}
        echo $HOST Password change OK!
    else
        echo $HOST has a problem!
        ((errors=errors+1))
    fi
done
((errors)) && exit 1


exit 0
