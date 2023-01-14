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
	
	if ($tmp =~ m/^\d{1,2}\.\s{1}/)
	{
		printf OUTHANDLE "\n";	
	}
	if ($tmp =~ m/--------/)
	{
		printf OUTHANDLE "\n";	
	}
	
	printf OUTHANDLE $tmp . " ";

	if ($tmp =~ m/--------/)
	{
		printf OUTHANDLE "\n";	
	}
}

close INHANDLE;
close OUTHANDLE;
