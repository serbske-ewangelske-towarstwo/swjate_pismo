#!/bin/bash

rm -rf 04_out
mkdir -p 04_out

for i in $(find 03_out/ -name "*.txt" | sort); do
	echo $i;
	./04_update_word_pair_list.pl $i $(echo $i | sed -e s/03_out/04_out/)
done
