#!/bin/bash

INFOLDER="../žórła/"
MAINFILENAME="swjate_pismo"

convert_to_latex() {
	for i in 000_titul.txt 004_pr_k_mojsaskowe.txt 005_d_k_mojsaskowe.txt; do
		echo $i;
		(cat $i | sed -e s/\)\)\)\)/\}\}/g \
		              -e s/\)\)/\}/g \
			          -e s/kapitl\(\(/\\\\chapter\*\{/g \
			          -e s/staw\(\(/\\\\section\*\{/g \
			          -e s/detail\(\(\(\(/\\\\subsection\*\{\\\\textit\{/g \
			          -e s/ref\(\(\(\(/\\\\hfill\ \{\\\\footnotesize\ \\\\textit\{/g) > $(echo $i | sed -e s/\.txt/\.tex/)
	done
}

###############################################################################

rm -rf 04_out_pdf
mkdir -p 04_out_pdf

cp $INFOLDER/* 04_out_pdf
pushd 04_out_pdf
convert_to_latex
PATH=$PATH:/usr/local/texlive/2022/bin/x86_64-linux/ latex $MAINFILENAME.tex
PATH=$PATH:/usr/local/texlive/2022/bin/x86_64-linux/ dvipdf $MAINFILENAME.dvi
popd

###############################################################################

rm -rf 04_out_epub
mkdir -p 04_out_epub

cp $INFOLDER/* 04_out_epub
pushd 04_out_epub
convert_to_latex
PATH=$PATH:/usr/local/texlive/2022/bin/x86_64-linux/ tex4ebook $MAINFILENAME.tex
popd

###############################################################################

rm -rf 04_out_html
mkdir -p 04_out_html

cp $INFOLDER/* 04_out_html
pushd 04_out_html
convert_to_latex
PATH=$PATH:/usr/local/texlive/2022/bin/x86_64-linux/ htlatex $MAINFILENAME.tex
popd


