#!/usr/bin/perl -w

use utf8;

my $INFILE = $ARGV[0];
my $OUTFILE = $ARGV[1];

printf "Reading $INFILE and writing $OUTFILE.\n";

open(INHANDLE, "$INFILE") or die ("Cannot open $INFILE for reading!");
binmode(INHANDLE, ":encoding(UTF-8)");
open(OUTHANDLE, "> $OUTFILE") or die ("Cannot open $OUTFILE for writing!");
binmode(OUTHANDLE, ":encoding(UTF-8)");

$TOC_LINE="";

while (<INHANDLE>)
{
	$tmp = $_;
	chomp($tmp);

	# replace "kapitl((...))" with latex command
	# \chapter*{...}
	if ($tmp =~ m/kapitl\(\(/)
	{
		# fetch the name of the chapter for the TOC line
		($tocline_content) = $tmp =~ m/kapitl\(\((.+)\)\)/;
		
		$tmp =~ s/\)\)/\}/;
		$tmp =~ s/kapitl\(\(/\\chapter\*\{/;
				
		$TOC_LINE = "\n\\addcontentsline{toc}{chapter}{\\protect\\numberline{}" . $tocline_content . "}\n\n\\markboth{" . $tocline_content . "}{" . $tocline_content . "}";
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
		
	# replace "vertspace(())" with latex command
	# \newline \noindent
	if ($tmp =~ m/vertspace\(\(/)
	{
		$tmp =~ s/\)\)//;
		$tmp =~ s/vertspace\(\(/\\vspace\{10mm\} \\noindent/;
	}
		
	print OUTHANDLE $tmp . "\n";
	
	if (length($TOC_LINE) > 0)
	{
		print OUTHANDLE $TOC_LINE . "\n";
		$TOC_LINE = "";
	}
}

close INHANDLE;
close OUTHANDLE;
