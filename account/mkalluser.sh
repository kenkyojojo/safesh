#!/bin/ksh

TYPE=$(echo $1 | tr [a-z] [A-Z])

cd /home/se/safechk/safesh/account

./mkuser.sh se se 022 300 seadm

./mkuser.sh se se 022 302 se02

./mkuser.sh security security 022 390 useradm

if [[ $TYPE = "OTC" ]];then
	./mkuser.sh otcexc otcexc 002 700 otcexadm
	./mkuser.sh otc otc 007 900 otc 
else 
	./mkuser.sh exc exc 002 600 exadm
	./mkuser.sh tse tse 007 800 twse
fi

exit 0
