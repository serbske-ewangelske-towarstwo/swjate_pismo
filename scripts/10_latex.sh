#!/bin/bash

INFOLDER="../žórła/"
MAINFILENAME="swjate_pismo"

MY_SCRIPT_PATH=$(pwd)

convert_to_latex() {
	for i in 000_titul.txt 004_pr_k_mojsaskowe.txt 005_d_k_mojsaskowe.txt \
	    060_sc_sw_marka.txt 061_sc_sw_lukasa.txt 062_sc_sw_jana.txt \
	    063_japost_stucki.txt 064_l_paw_romskich.txt 065_p_l_paw_korinth.txt \
	    066_d_l_paw_korinth.txt 067_l_paw_salatis.txt 068_l_paw_ephesis.txt \
	    069_l_paw_philipp.txt 070_l_paw_kolosej.txt 071_p_l_paw_thesalon.txt \
	    072_d_l_thesalon-NOTCORR.txt 073_p_l_paw_timothej-NOTCORR.txt 074_d_l_paw_timothej-NOTCORR.txt ; do
		echo $i;
#		(cat $i | sed -e s/\)\)\)\)/\}\}/g \
#		              -e s/\)\)/\}/g \
#			          -e s/kapitl\(\(/\\\\chapter\*\{/g \
#			          -e s/staw\(\(/\\\\section\*\{/g \
#			          -e s/detail\(\(\(\(/\\\\subsection\*\{\\\\textit\{/g \
#			          -e s/ref\(\(\(\(/\\\\hfill\ \{\\\\footnotesize\ \\\\textit\{/g) > $(echo $i | sed -e s/\.txt/\.tex/)

	perl ${MY_SCRIPT_PATH}/10_latex.pl $i $(echo $i | sed -e s/\.txt/\.tex/)

	done
}

###############################################################################

rm -rf 10_out_pdf
mkdir -p 10_out_pdf

cp $INFOLDER/* 10_out_pdf
pushd 10_out_pdf
convert_to_latex
PATH=$PATH:/usr/local/texlive/2022/bin/x86_64-linux/ latex $MAINFILENAME.tex
PATH=$PATH:/usr/local/texlive/2022/bin/x86_64-linux/ latex $MAINFILENAME.tex
PATH=$PATH:/usr/local/texlive/2022/bin/x86_64-linux/ dvipdf $MAINFILENAME.dvi
popd

###############################################################################

rm -rf 10_out_epub
mkdir -p 10_out_epub

cp $INFOLDER/* 10_out_epub
pushd 10_out_epub
convert_to_latex
PATH=$PATH:/usr/local/texlive/2022/bin/x86_64-linux/ tex4ebook $MAINFILENAME.tex
PATH=$PATH:/usr/local/texlive/2022/bin/x86_64-linux/ tex4ebook $MAINFILENAME.tex
popd

###############################################################################

rm -rf 10_out_html
mkdir -p 10_out_html

cp $INFOLDER/* 10_out_html
pushd 10_out_html
convert_to_latex
PATH=$PATH:/usr/local/texlive/2022/bin/x86_64-linux/ htlatex $MAINFILENAME.tex "xhtml,1,sections+,charset=utf-8" " -cmozhtf -utf8"
PATH=$PATH:/usr/local/texlive/2022/bin/x86_64-linux/ htlatex $MAINFILENAME.tex "xhtml,1,sections+,charset=utf-8" " -cmozhtf -utf8"
popd


