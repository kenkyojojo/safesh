#!/usr/bin/perl -w
use strict;
##########################################################
## Target:						## 
## collect & filter uid, pid, ppid and cmd column	## 
## from ps -ef result then export to record		##
##							##
## Date:   2013/03/27					##
## Ver:    1.0						##
## Author: Jammy Yu					##
##########################################################

my $log_path = '/home/se/safechk/selog/log';
my $chk_time = `date +%Y%m%d%H%M%S`;
my @process = `ps -ef | grep -v UID`;

chomp($chk_time);

open(FHD, "> $log_path/process_$chk_time.log") || die "$!\n";

foreach (@process)
{
   chomp;
    
   ##     $1=UID  $2=PID  $3=PPID                 $4=CMD
   $_ =~ /(\w+)\s+(\d+)\s+(\d+).+?[-|pts].+?:.+?\s+(.+)/;
   
   print FHD "$chk_time,$1,$2,$3,$4\n";
}

close(FHD);
