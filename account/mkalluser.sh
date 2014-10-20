#!/bin/ksh

cd /home/se/safechk/safesh/account

./mkuser.sh se se 022 300 seadm

./mkuser.sh se se 022 302 se02

./mkuser.sh exc exc 002 600 exadm

./mkuser.sh otcexc otcexc 002 700 otcexadm

./mkuser.sh tse tse 007 800 twse

./mkuser.sh otc otc 007 900 otc

./mkuser.sh security security 022 390 useradm

exit
