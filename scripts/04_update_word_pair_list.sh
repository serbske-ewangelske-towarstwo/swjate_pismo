#!/bin/bash

rm -rf 04_out
mkdir -p 04_out

for i in $(find 03_out/ -name "*.txt" | sort); do
	echo $i;
	OUTFILENAME=$(echo $i | sed -e s/03_out/04_out/ -e s/\.txt/\.tsv/)
	./04_update_word_pair_list.pl $i $OUTFILENAME
	sort -n -r $OUTFILENAME > $OUTFILENAME.tmp
	mv $OUTFILENAME.tmp $OUTFILENAME
done
