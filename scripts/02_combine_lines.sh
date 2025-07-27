#!/bin/bash

rm -rf 02_out
mkdir -p 02_out

for i in $(find 01_out/ -name "*.txt" | sort); do
	echo $i;
	perl ./02_combine_lines.pl $i $(echo $i | sed -e s/01_out/02_out/)
done
