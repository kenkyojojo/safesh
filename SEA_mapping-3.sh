#!/usr/bin/ksh
IOS=/usr/ios/cli/ioscli
####mapping vlan101 SEA ent44 ####
$IOS mkvdev -sea ent38 -vadapter ent20 -default ent20 -defaultid 101 -attr ha_mode=auto ctl_chan=ent29

####mapping vlan102 SEA ent45 ####
$IOS mkvdev -sea ent39 -vadapter ent21 -default ent21 -defaultid 102 -attr ha_mode=auto ctl_chan=ent30

####mapping vlan112 SEA ent46 ####
$IOS mkvdev -sea ent40 -vadapter ent22 -default ent22 -defaultid 112 -attr ha_mode=auto ctl_chan=ent31

####mapping vlan2 SEA ent47 ####
$IOS mkvdev -sea ent41 -vadapter ent23 -default ent23 -defaultid 2 -attr ha_mode=auto ctl_chan=ent32

####mapping vlan21 SEA ent48 ####
$IOS mkvdev -sea ent42 -vadapter ent24 -default ent24 -defaultid 21 -attr ha_mode=auto ctl_chan=ent33

####mapping vlan121 SEA ent49 ####
$IOS mkvdev -sea ent43 -vadapter ent25 -default ent25 -defaultid 121 -attr ha_mode=auto ctl_chan=ent34

####mapping vlan4 SEA ent50 ####
$IOS mkvdev -sea ent3 -vadapter ent26 -default ent26 -defaultid 4 -attr ha_mode=auto ctl_chan=ent35

####mapping vlan5 SEA ent51 ####
$IOS mkvdev -sea ent14 -vadapter ent27 -default ent27 -defaultid 5 -attr ha_mode=auto ctl_chan=ent36

####mapping vlan6 SEA ent52 ####
$IOS mkvdev -sea ent15 -vadapter ent28 -default ent28 -defaultid 15 -attr ha_mode=auto ctl_chan=ent37
