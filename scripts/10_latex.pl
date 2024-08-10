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

	# replace "kapitl((...))" with latex command
	# \chapter*{...}
	if ($tmp =~ m/kapitl\(\(/)
	{
		$tmp =~ s/\)\)/\}/;
		$tmp =~ s/kapitl\(\(/\\chapter\*\{/;
	}
	
	
	# replace "staw((...))" with latex command
	# \section*{...}
	if ($tmp =~ m/staw\(\(/)
	{
		$tmp =~ s/\)\)/\}/;
		$tmp =~ s/staw\(\(/\\section\*\{/;
	}
	
	# replace "detail((...))" with latex command
	# \subsection*{ \textit{...}}
	if ($tmp =~ m/detail\(\(/)
	{
		$tmp =~ s/\)\)/\}\}/;
		$tmp =~ s/detail\(\(/\\subsection\*\{ \\textit\{/;
	}
	
	# replace "ref((...))" with latex command
	# \hfill {\footnotesize \textit{...}}
	if ($tmp =~ m/ref\(\(/)
	{
		$tmp =~ s/\)\)/\}\}/;
		$tmp =~ s/ref\(\(/\\hfill\ \{\\footnotesize\ \\textit\{/;
	}
		
	print OUTHANDLE $tmp . "\n";	
}

close INHANDLE;
close OUTHANDLE;
