#!/bin/bash

rm -rf 04_out
mkdir -p 04_out

if /bin/true; then
	for i in $(find 03_out/ -name "*.txt" | sort); do
		echo $i;
		OUTFILENAME=$(echo $i | sed -e s/03_out/04_out/ -e s/\.txt/\.tsv/)
		perl ./04_update_word_pair_list.pl $i $OUTFILENAME
		sort -n -r $OUTFILENAME > $OUTFILENAME.tmp
		mv $OUTFILENAME.tmp $OUTFILENAME
	done
fi
	
# special handling: merge short chapters into one to generate a useful replacement list

# letters from new testament
if /bin/false; then
	
	INFILENAME=tmp_combined_letters.txt
	rm -f $INFILENAME
	cat 03_out/067_l_paw_salatis.txt 03_out/068_l_paw_ephesis.txt 03_out/069_l_paw_philipp.txt \
	    03_out/070_l_paw_kolosej.txt 03_out/071_p_l_paw_thesalon.txt 03_out/072_d_l_thesalon.txt \
	    03_out/073_p_l_paw_timothej.txt 03_out/074_d_l_paw_timothej.txt 03_out/075_l_paw_tita.txt \
	    03_out/076_l_paw_philemon.txt 03_out/077_p_l_petra.txt 03_out/078_d_l_petra.txt 03_out/079_p_l_jana.txt \
	    03_out/080_d_l_jana.txt 03_out/081_t_l_jana.txt 03_out/082_l_n_hebrej.txt 03_out/083_l_sw_jakuba.txt \
	    03_out/084_l_sw_judasa.txt 03_out/085_sjew_sw_jana.txt > $INFILENAME
	    	
	OUTFILENAME=tmp_combined_letters_out.txt
	perl ./04_update_word_pair_list.pl $INFILENAME $OUTFILENAME
	sort -n -r $OUTFILENAME > $OUTFILENAME.tmp
	mv $OUTFILENAME.tmp $OUTFILENAME
	
fi
