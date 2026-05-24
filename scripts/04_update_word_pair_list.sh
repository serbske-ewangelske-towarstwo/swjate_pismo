#!/bin/bash

rm -rf 04_out
mkdir -p 04_out

if /bin/false; then
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

# all files from old testament
if /bin/true; then
	
	INFILENAME=tmp_combined_old.txt
	rm -f $INFILENAME
	cat 03_out/000_titul.txt 03_out/001_predslowo.txt 03_out/002_s_t_knihi.txt \
		03_out/003_s_t_pokazar.txt 03_out/004_pr_k_mojsaskowe.txt \
		03_out/005_d_k_mojsaskowe.txt 03_out/006_t_k_mojsaskowe.txt \
		03_out/007_s_k_mojsaskowe.txt 03_out/008_pj_k_mojsaskowe.txt \
		03_out/009_k_josuowe.txt \
		03_out/010_k_sudnikow.txt \
		03_out/011_k_ruthy.txt \
		03_out/012_p_k_samuela.txt \
		03_out/013_d_k_samuela.txt \
		03_out/014_p_k_kralow.txt \
		03_out/015_d_k_kralow.txt \
		03_out/016_p_k_kronikow.txt \
		03_out/017_d_k_kronikow.txt \
		03_out/018_k_esry.txt \
		03_out/019_k_nehemiasa.txt \
		03_out/020_k_esthery.txt \
		03_out/021_k_hiobowe.txt \
		03_out/022_psalmy.txt \
		03_out/023_pri_salomonowe.txt \
		03_out/024_pre_salomon.txt \
		03_out/025_w_k_salomonowy.txt \
		03_out/026_jesajas.txt \
		03_out/027_jeremias.txt \
		03_out/028_z_k_jeremiasa.txt \
		03_out/029_ezechiel.txt \
		03_out/030_daniel.txt \
		03_out/031_hoseas.txt \
		03_out/032_joel.txt \
		03_out/033_amos.txt \
		03_out/034_obadja.txt \
		03_out/035_jonas.txt \
		03_out/036_micha.txt \
		03_out/037_nahum.txt \
		03_out/038_habakuk.txt \
		03_out/039_zephanja.txt \
		03_out/040_haggai.txt \
		03_out/041_sacharja.txt \
		03_out/042_malachias.txt \
		03_out/043_k_judithy.txt \
		03_out/044_k_sal_mudrosce.txt \
		03_out/045_k_tobiasa.txt \
		03_out/046_k_jesusa_siracha.txt \
		03_out/047_k_barucha.txt \
		03_out/048_p_k_makkabejske.txt \
		03_out/049_d_k_makkabejske.txt \
		03_out/050_kruchi_estherowych.txt \
		03_out/051_hist_susannje.txt \
		03_out/052_bel_w_babelu.txt \
		03_out/053_smij_w_babelu.txt \
		03_out/054_m_afariasowa.txt \
		03_out/055_trjoch_muzow.txt \
		03_out/056_m_manasowa.txt \
		03_out/057_n_t_titul.txt \
		03_out/058_n_t_knihi.txt \
	> $INFILENAME
	    	
	OUTFILENAME=tmp_combined_old_out.txt
	perl ./04_update_word_pair_list.pl $INFILENAME $OUTFILENAME
	sort -n -r $OUTFILENAME > $OUTFILENAME.tmp
	mv $OUTFILENAME.tmp $OUTFILENAME
	
fi
