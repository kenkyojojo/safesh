#!/bin/ksh

cd /home/se/safechk/safesh/account

./mkuser.sh se se 022 300 seadm

./mkuser.sh se se 022 301 se01

./mkuser.sh se se 022 302 se02

./mkuser.sh exc exc 002 600 exadm

./mkuser.sh exc exc 002 611 ex11

./mkuser.sh exc exc 002 614 ex14

./mkuser.sh exc exc 002 616 ex16

./mkuser.sh tse tse 007 800 twse

./mkuser.sh security security 022 390 useradm

exit
