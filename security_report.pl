#!/usr/bin/perl
##---------------------------------------------------------------------
# Set variable
#---------------------------------------------------------------------
$SITE="TSEOT1";
$HOSTNAME=`hostname`;
$DATE=`date +%Y%m%d`;
$SHDIR="/home/se/safechk/safesh";
$SHCFG="/home/se/safechk/cfg";
$LOGDIR="/home/se/safechk/safelog";
$REPORTDIR="/home/se/safechk/selog/log";
$LOG="$LOGDIR/security_report.log";
$WKLPAR="WKLPART1";
$trailmod=1;
$GARVG=$1;

##---------------------------------------------------------------------
# Set raw data variable
#---------------------------------------------------------------------

$ntp_CHKLOG="$LOGDIR/ntp_chk.$DATE";
$sys_CHKLOG="$LOGDIR/sys_chk.$DATE";
$aut_CHKLOG="$LOGDIR/aut_chk.$DATE";
$atr_CHKLOG="$LOGDIR/atr_chk.$DATE";
$adm_CHKLOG="$LOGDIR/adm_chk.$DATE";
$sba_CHKLOG="$LOGDIR/sba_chk.$DATE";

##---------------------------------------------------------------------
# Set report file variable
#---------------------------------------------------------------------

$ntp_REPORT="$REPORTDIR/ntp_report.$DATE";
$sys_REPORT="$REPORTDIR/sys_report.$DATE";
$aut_REPORT="$REPORTDIR/aut_report.$DATE";
$atr_REPORT="$REPORTDIR/atr_report.$DATE";
$adm_REPORT="$REPORTDIR/adm_report.$DATE";
$sba_REPORT="$REPORTDIR/sba_report.$DATE";

#---------------------------------------------------------------------
# Show running step status
#---------------------------------------------------------------------

sub tlog(){
chomp (($msg)=@_);
#(@msg)=@_;
    if ( $trailmod == 1){
	   	chomp ($dt=`date +"%y/%m/%d %H:%M:%S"`);
		print "$SITE [${dt}] $msg\n";
		return "$SITE [${dt}] $msg\n";
	}
} 

sub main(){
$RVR=&tlog($HOSTNAME);
#	&tlog($HOSTNAME);
	print $RVR
}

&main ;
