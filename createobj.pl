#!/usr/bin/perl

#$LISTFILE="./objectlst.txt";
$APP02="/TWSE/appia/applogs/FW101/APP02";

$W="w = \"TEST_FILE_WR\"";
$R="r = \"TEST_FILE_RD\"";
$X="x = \"TEST_FILE_EX\"";


sub object{

opendir(DIR,"$APP02") or die "Please to check the directory.\n $!" ;
open (TARGETF,"> object" ) || die "Could not open file: $! \n"; 

    foreach ( readdir(DIR) ){
	if ($_ =~ /[^\.*]/) {
		chomp $_;
		print TARGETF "\n";
		print TARGETF "${APP02}\\$_:\n";
       		print TARGETF ' 'x8; print TARGETF "$W \n";
       		print TARGETF ' 'x8; print TARGETF "$R \n";
       		print TARGETF ' 'x8; print TARGETF "$X \n";
	}
    }

}

close TARGETF;
closedir DIR;

sub main {
    &object;
}

&main;
