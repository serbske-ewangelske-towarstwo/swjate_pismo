#!/usr/bin/perl -w

my $INFILE = $ARGV[0];
my $OUTFILE = $ARGV[1];

printf "Reading $INFILE and writing $OUTFILE.\n";

open(INHANDLE, "$INFILE") or die ("Cannot open $INFILE for reading!");
open(OUTHANDLE, "> $OUTFILE") or die ("Cannot open $OUTFILE for writing!");

# simple logic:
# 
# remove all linefeeds, unless
# a "bible verse start" is detected or
# the special link to the original is found
while (<INHANDLE>)
{
	$tmp = $_;
	chomp($tmp);
	
	# detect beginning of a verse (number + .) --> linefeed b4
	if ($tmp =~ m/^\d{1,2}\.\s{1}/)
	{
		printf OUTHANDLE "\n";	
	}
	
	# detect link to original --> linefeed b4
	if ($tmp =~ m/--------/)
	{
		printf OUTHANDLE "\n";	
	}
	
	# write content
	printf OUTHANDLE $tmp . " ";

	
	# detect link to original --> linefeed after
	if ($tmp =~ m/--------/)
	{
		printf OUTHANDLE "\n";	
	}
}

close INHANDLE;
close OUTHANDLE;
