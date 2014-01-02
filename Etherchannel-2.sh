#!/usr/bin/ksh
IOS=/usr/ios/cli/ioscli

#ent38 VLAN101
$IOS mkvdev -lnagg ent12 ent13 -attr mode=8023ad

#ent39 VLAN102
$IOS mkvdev -lnagg ent8 ent9 -attr mode=8023ad

#ent40 VLAN112
$IOS mkvdev -lnagg ent10 ent11 -attr mode=8023ad

#ent41 VLAN2
$IOS mkvdev -lnagg ent0 ent1 ent12 -attr mode=8023ad

#ent42 VLAN21
$IOS mkvdev -lnagg ent4 ent5 -attr mode=8023ad

#ent43 VLAN121
$IOS mkvdev -lnagg ent6 ent7 -attr mode=8023ad
