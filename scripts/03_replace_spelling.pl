#!/usr/bin/perl -w

use utf8;

my $INFILE = $ARGV[0];
my $OUTFILE = $ARGV[1];

printf "Reading $INFILE and writing $OUTFILE.\n";

open(INHANDLE, "$INFILE") or die ("Cannot open $INFILE for reading!");
binmode(INHANDLE, ":encoding(UTF-8)");
open(OUTHANDLE, "> $OUTFILE") or die ("Cannot open $OUTFILE for writing!");
binmode(OUTHANDLE, ":encoding(UTF-8)");


open(PAIRHANDLE, "03_word_pairs.txt") or die ("Cannot open file for word pair replacements!");
binmode(PAIRHANDLE, ":encoding(UTF-8)");

my $index_pairs = 0;
my @word_pairs;
while (<PAIRHANDLE>)
{
	$tmp = $_;
	chomp($tmp);
	($word_pairs[$index_pairs][0], $word_pairs[$index_pairs][1]) = $tmp =~ m/^(.+)\t(.+)$/;
	#print $word_pairs[$index_pairs][0] . " : " . $word_pairs[$index_pairs][1] . "\n";
	$index_pairs++;
	$word_pairs[$index_pairs][0] = ucfirst($word_pairs[$index_pairs - 1][0]);
	$word_pairs[$index_pairs][1] = ucfirst($word_pairs[$index_pairs - 1][1]);
	# print $word_pairs[$index_pairs][0] . " : " . $word_pairs[$index_pairs][1] . "\n";
	$index_pairs++;
}

close PAIRHANDLE;

while (<INHANDLE>)
{
	$tmp = $_;
	chomp($tmp);

	# replace letters and combinations
	$tmp =~ s/ſch/š/g;
	$tmp =~ s/cź/ć/g;
	$tmp =~ s/cž/č/g;
	$tmp =~ s/ſ/z/g;
	$tmp =~ s/ß/s/g;
	
	# replace syllable separator
	$tmp =~ s/⸗ //g;
	
	# replace words from list
	my $index_rep;
	for ($index_rep = 0; $index_rep < $index_pairs; $index_rep++)
	{
		$tmp =~ s/$word_pairs[$index_rep][0]/$word_pairs[$index_rep][1]/g;
	}
	
	printf OUTHANDLE $tmp . "\n";	
}

close INHANDLE;
close OUTHANDLE;
