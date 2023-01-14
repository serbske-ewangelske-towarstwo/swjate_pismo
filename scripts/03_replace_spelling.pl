#!/usr/bin/perl -w

my $INFILE = $ARGV[0];
my $OUTFILE = $ARGV[1];

printf "Reading $INFILE and writing $OUTFILE.\n";

open(INHANDLE, "$INFILE") or die ("Cannot open $INFILE for reading!");
open(OUTHANDLE, "> $OUTFILE") or die ("Cannot open $OUTFILE for writing!");

while (<INHANDLE>)
{
	$tmp = $_;
	chomp($tmp);

	$tmp =~ s/ſch/š/g;
	$tmp =~ s/cź/ć/g;
	$tmp =~ s/cž/č/g;
	$tmp =~ s/ſ/z/g;
	$tmp =~ s/ß/s/g;
	
	printf OUTHANDLE $tmp . "\n";	
}

close INHANDLE;
close OUTHANDLE;
