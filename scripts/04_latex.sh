#!/bin/bash

INFOLDER="../žórła/"
MAINFILENAME="swjate_pismo"

rm -rf 04_out_pdf
mkdir -p 04_out_pdf

cp $INFOLDER/* 04_out_pdf
pushd 04_out_pdf
PATH=$PATH:/usr/local/texlive/2022/bin/x86_64-linux/ latex $MAINFILENAME.tex
PATH=$PATH:/usr/local/texlive/2022/bin/x86_64-linux/ dvipdf $MAINFILENAME.dvi
popd

rm -rf 04_out_epub
mkdir -p 04_out_epub

cp $INFOLDER/* 04_out_epub
pushd 04_out_epub
PATH=$PATH:/usr/local/texlive/2022/bin/x86_64-linux/ tex4ebook $MAINFILENAME.tex
popd

rm -rf 04_out_html
mkdir -p 04_out_html

cp $INFOLDER/* 04_out_html
pushd 04_out_html
PATH=$PATH:/usr/local/texlive/2022/bin/x86_64-linux/ htlatex $MAINFILENAME.tex
popd


