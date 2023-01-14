#!/bin/bash

rm -f 04_out_pdf
mkdir -p 04_out_pdf

cp test.tex 04_out_pdf
pushd 04_out_pdf
PATH=$PATH:/usr/local/texlive/2022/bin/x86_64-linux/ latex test.tex
PATH=$PATH:/usr/local/texlive/2022/bin/x86_64-linux/ dvipdf test.dvi
popd

rm -f 04_out_epub
mkdir -p 04_out_epub

cp test.tex 04_out_epub
pushd 04_out_epub
PATH=$PATH:/usr/local/texlive/2022/bin/x86_64-linux/ tex4ebook test.tex
popd

rm -f 04_out_html
mkdir -p 04_out_html

cp test.tex 04_out_html
pushd 04_out_html
PATH=$PATH:/usr/local/texlive/2022/bin/x86_64-linux/ htlatex test.tex
popd


