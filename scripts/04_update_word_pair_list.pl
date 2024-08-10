#!/usr/bin/perl -w

use utf8;

my $INFILE = $ARGV[0];
my $OUTFILE = $ARGV[1];

printf "Reading $INFILE and writing $OUTFILE.\n";

open(INHANDLE, "$INFILE") or die ("Cannot open $INFILE for reading!");
binmode(INHANDLE, ":encoding(UTF-8)");
open(OUTHANDLE, "> $OUTFILE") or die ("Cannot open $OUTFILE for writing!");
binmode(OUTHANDLE, ":encoding(UTF-8)");

while (<INHANDLE>)
{
	$tmp = $_;
	chomp($tmp);

	# detect beginning of a verse (number + .) 
	#
	# don't use other lines for assembling the list (yet)
	if ($tmp =~ m/^\d{1,2}\.\s{1}/)
	{
		# we don't want the verse number(s) in the list
		$tmp =~ s/^\d{1,2}\.\s{1}//;		
		
		# we don't want the references at the end, either
		# TBD
		
		my @words = split /\s+/, $tmp;
		
		foreach (@words)
		{
			$word = $_;
			chomp($word);
			
			# remove numbers with dot at end
			$word =~ s/\d{1,2}\.//;
			
			# remove numbers with , at end (maybe OCR failures)
			$word =~ s/\d{1,2}\,//;
			
			# now remove all special symbols
			$word =~ s/\,//;
			$word =~ s/\.//;
			$word =~ s/\://;
			$word =~ s/\;//;
			$word =~ s/\!//;
			$word =~ s/\?//;
			
			# only write word if it sill contains sth.
			if ($word =~ m/^\s*$/)
			{
				# print "Remainder: -> $word <- \n" 
			}
			else
			{
				printf OUTHANDLE $word . "\n";
			}
		}
	}
}

close INHANDLE;
close OUTHANDLE;
