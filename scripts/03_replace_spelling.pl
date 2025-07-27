#!/usr/bin/perl -w

use utf8;

my $INFILE = $ARGV[0];
my $OUTFILE = $ARGV[1];

printf "Reading $INFILE and writing $OUTFILE.\n";

open(INHANDLE, "$INFILE") or die ("Cannot open $INFILE for reading!");
binmode(INHANDLE, ":encoding(UTF-8)");
open(OUTHANDLE, "> $OUTFILE") or die ("Cannot open $OUTFILE for writing!");
binmode(OUTHANDLE, ":encoding(UTF-8)");

# 1. read the "word pairs" file with all replacements
# ever pair is twice in the list, one time all lower case,
# one time with capital letter at word start

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
	
	# for the purpose of this script, we filter out the 1:1 pairs to keep the replacement list short
	if ($word_pairs[$index_pairs][0] ne $word_pairs[$index_pairs][1])
	{
		if ($word_pairs[$index_pairs][0] ne ucfirst($word_pairs[$index_pairs][0]))
		{
			$index_pairs++;
			$word_pairs[$index_pairs][0] = ucfirst($word_pairs[$index_pairs - 1][0]);
			$word_pairs[$index_pairs][1] = ucfirst($word_pairs[$index_pairs - 1][1]);
			# print $word_pairs[$index_pairs][0] . " : " . $word_pairs[$index_pairs][1] . "\n";
			$index_pairs++;
		}
		else
		{
			printf("INFO: There is no upper case variant for %s.\n", $word_pairs[$index_pairs][0]);
		}
	}
	else
	{
		# equal word pairs should not be in the list at all anymore (moved to separate file), so warn here
		printf("ERROR!!!!!!!!!!!!!!! Equal word pair %s should not be in list !!!!!!!!!!!!!!!!!!!!!\n", $word_pairs[$index_pairs][0]);	
	}
}

close PAIRHANDLE;

# 2. run replacements for every line (hopefully properly arranged in verses) 

while (<INHANDLE>)
{
	$tmp = $_;
	chomp($tmp);

	# replace letters and combinations where it is 100% clear this cannot be current spelling
	$tmp =~ s/ſch/š/g;
	$tmp =~ s/cź/ć/g;
	$tmp =~ s/cž/č/g;
	$tmp =~ s/ſ/z/g;
	$tmp =~ s/ß/s/g;
	
	# replace syllable separator (this hopefully un-breaks words)
	$tmp =~ s/⸗ //g;
	
	# replace words from list
	my $index_rep;
	for ($index_rep = 0; $index_rep < $index_pairs; $index_rep++)
	{
		$tmp =~ s/\b$word_pairs[$index_rep][0]\b/$word_pairs[$index_rep][1]/g;
	}
	
	# replace this special character if not already done by replacement list
	$tmp =~ s/⸗/-/g;
		
	printf OUTHANDLE $tmp . "\n";	
}

close INHANDLE;
close OUTHANDLE;
