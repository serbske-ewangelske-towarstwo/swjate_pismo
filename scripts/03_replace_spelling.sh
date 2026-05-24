#!/bin/bash

rm -rf 03_out
mkdir -p 03_out

for i in $(find 02_out/ -name "*.txt" | sort); do
	echo $i;
	perl ./03_replace_spelling.pl $i $(echo $i | sed -e s/02_out/03_out/)
	if [ "$i" = "02_out/058_n_t_knihi.txt" ]; then
		echo "=================================================="
		echo "Script can be interrupted, all non-finished files processed!"
		echo "=================================================="
	fi
done
