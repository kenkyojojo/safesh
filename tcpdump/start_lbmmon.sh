set -e
lbmmon --transport-opts="config=/home/ap01/rando/mon.cfg" > /home/ap01/rando/mon.log.`date +%Y%m%d` 2>/home/ap01/rando/mon.log.`date +%Y%m%d` &

