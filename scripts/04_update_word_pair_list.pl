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
	# for the purpose of this script, we want to use all pairs (even equal ones)
	# and we only need the lower case variant
	$tmp = $_;
	chomp($tmp);
	($word_pairs[$index_pairs][0], $word_pairs[$index_pairs][1]) = $tmp =~ m/^(.+)\t(.+)$/;
	#print $word_pairs[$index_pairs][0] . " : " . $word_pairs[$index_pairs][1] . "\n";
	$index_pairs++;
}

close PAIRHANDLE;

# printf("Filtering out %d replacement word pairs!\n", $index_pairs);

# 2. read the file with the "equal" word pairs, e.g. those that have been reviewed as ok
# this makes the word pair list to check shorter each time new accepted "equal" words are added

open(EQUALHANDLE, "04_equal_word_pairs.txt") or die ("Cannot open file for equal word pair replacements!");
binmode(EQUALHANDLE, ":encoding(UTF-8)");

while (<EQUALHANDLE>)
{
	# for the purpose of this script, we want to use all pairs (even equal ones)
	# and we only need the lower case variant
	$tmp = $_;
	chomp($tmp);
	($word_pairs[$index_pairs][0], $word_pairs[$index_pairs][1]) = $tmp =~ m/^(.+)\t(.+)$/;
	#print $word_pairs[$index_pairs][0] . " : " . $word_pairs[$index_pairs][1] . "\n";
	
	# sanity check, pairs must be equal
	if ($word_pairs[$index_pairs][0] ne $word_pairs[$index_pairs][1])
	{
		printf("ERROR!!!!!!!!!!!!!!! Equal word pair expected !!!!!!!!!!!!!!!!!!!!!\n");	
	}
		
	$index_pairs++;
}

close EQUALHANDLE;

# printf("List extended to %d word pairs (equal pairs added)!\n", $index_pairs);

# 3. process current file

my @wordlist;
my @occurrences;

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
			$word =~ s/\d{1,3}\.//;
			
			# remove numbers with , at end (maybe OCR failures)
			$word =~ s/\d{1,3}\,//;
			
			# remove remaining numbers
			$word =~ s/\d{1,3}//;
			
			# now remove all special symbols
			$word =~ s/\,//;
			$word =~ s/\.//;
			$word =~ s/\://;
			$word =~ s/\;//;
			$word =~ s/\!//;
			$word =~ s/\?//;
			$word =~ s/\„//;
			$word =~ s/\|//;
			$word =~ s/\—//;
			$word =~ s/\(//;
			$word =~ s/\)//;
			
			# only consider word if it sill contains sth.
			if ($word =~ m/^\s*$/)
			{
				# print "Remainder: -> $word <- \n" 
			}
			else
			{
				# list shall only contain lower case words
				$word = lc($word);
				
				my $foundit = 0;
				
				# look up word if we already added it to list
				my $index;
				for ($index = 0; $index < @wordlist; $index++)
				{
					if ($word eq $wordlist[$index])
					{
						$foundit = 1;
						$occurrences[$index]++;
						# printf("Word %s occurences %d.\n", $word, $occurrences[$index]);
						last;
					}
				}
				
				# add word that is not yet in list
				if ($foundit == 0)
				{
					# unless it is already part of our word pair list
					for ($index = 0; $index < @word_pairs; $index++)
					{
						# if it is on the list, it can only be in the 2nd column
						if ($word_pairs[$index][1] eq $word)
						{
							$foundit = 1;
							last;
						}
						
						# sanity check, word is in 1st column - must not happen
						if ($word_pairs[$index][0] eq $word)
						{
							printf("Error!!! Why is word %s not replaced?\n", $word);
						}						
					}
					
					if ($foundit == 0)
					{
						push @wordlist, $word;
						push @occurrences, 1;
					}
				}
				
				# printf OUTHANDLE $word . "\n";
			}
		}
	}
}

# write list to file
my $writeindex;
for ($writeindex = 0; $writeindex < @wordlist; $writeindex++)
{
	printf OUTHANDLE "%d\t%s\t%s\n", $occurrences[$writeindex], $wordlist[$writeindex], $wordlist[$writeindex];	
}

close INHANDLE;
close OUTHANDLE;
