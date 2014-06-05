#!/bin/ksh

cd /home/se/safechk/safesh/account

./mkuser.sh se se 022 300 seadm

./mkuser.sh se se 022 302 se02

./mkuser.sh exc exc 002 600 exadm

./mkuser.sh exc exc 002 605 ex05

./mkuser.sh exc exc 002 610 ex10

./mkuser.sh exc exc 002 611 ex11

./mkuser.sh exc exc 002 614 ex14

./mkuser.sh exc exc 002 615 ex15

./mkuser.sh tse tse 007 800 twse

./mkuser.sh security security 022 390 useradm

exit
