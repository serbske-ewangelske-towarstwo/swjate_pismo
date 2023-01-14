#!/usr/bin/perl -w

my @chapters  = ("titul", "predslowo", "s_t_knihi", "s_t_pokazar", "pr_k_mojsaskowe", "d_k_mojsaskowe", "t_k_mojsaskowe", "s_k_mojsaskowe", "pj_k_mojsaskowe", "k_josuowe", "k_sudnikow", "k_ruthy", "p_k_samuela", "d_k_samuela", "p_k_kralow", "d_k_kralow", "p_k_kronikow", "d_k_kronikow", "k_esry", "k_nehemiasa", "k_esthery", "k_hiobowe", "psalmy", "pri_salomonowe", "pre_salomon", "w_k_salomonowy", "jesajas", "jeremias", "z_k_jeremiasa", "ezechiel", "daniel", "hoseas", "joel", "amos", "obadja", "jonas", "micha", "nahum", "habakuk", "zephanja", "haggai", "sacharja", "malachias", "k_judithy", "k_sal_mudrosce", "k_tobiasa", "k_jesusa_siracha", "k_barucha", "p_k_makkabejske", "d_k_makkabejske", "kruchi_estherowych", "hist_susannje", "bel_w_babelu", "smij_w_babelu", "m_afariasowa", "trjoch_muzow", "m_manasowa", "n_t_titul", "n_t_knihi", "sc_sw_mattheia", "sc_sw_marka", "sc_sw_lukasa", "sc_sw_jana", "japost_stucki", "l_paw_romskich", "p_l_paw_korinth", "d_l_paw_korinth", "l_paw_salatis", "l_paw_ephesis", "l_paw_philipp", "l_paw_kolosej", "p_l_paw_thesalon", "d_l_thesalon", "p_l_paw_timothej", "d_l_paw_timothej", "l_paw_tita", "l_paw_philemon", "p_l_petra", "d_l_petra", "p_l_jana", "d_l_jana", "t_l_jana", "l_n_hebrej", "l_sw_jakuba", "l_sw_judasa", "sjew_sw_jana");
my @ch_start  = (      5,           7,           9,            11,                13,               83,              141,              183,               241,         280,          324,       357,           361,           405,          441,          482,            522,            559,      605,           618,         636,         646,      682,              772,           802,              812,       817,        886,             960,        966,     1034,     1054,   1064,   1067,     1075,    1076,    1078,    1084,      1087,       1090,     1093,       1095,        1106,        1110,             1126,        1146,               1160,        1214,              1223,              1264,                 1293,            1298,           1300,            1302,           1303,           1304,         1306,        1307,        1308,             1309,          1357,           1387,         1438,            1477,             1526,              1546,              1567,            1580,            1587,            1594,            1599,               1603,           1608,               1610,               1615,         1619,             1622,        1623,        1628,       1632,       1637,       1638,         1638,          1653,          1658,           1660);
my @start_off = (      0,           0,           0,             0,                 0,               75,                0,                0,                 0,           0,            0,         0,             0,             0,            0,            0,              0,              0,        0,             0,           0,           0,        0,                0,             0,                0,         0,          0,               0,          0,        0,        0,      0,      0,        0,       0,       0,       0,         0,          0,        0,          0,           0,           0,                0,           0,                  0,           0,                 0,                 0,                    0,               0,              0,               0,              0,              0,            0,           0,           0,                0,             0,              0,            0,               0,                0,                 0,                 0,               0,               0,               0,               0,                  0,              0,                  0,                  0,            0,                0,           0,           0,          0,          0,          0,            0,             0,             0,              0);
my @ch_end    = (      5,           8,          10,            11,                83,              141,              183,              241,               279,         324,          357,       361,           405,           441,          482,          522,            559,            605,      618,           636,         646,         682,      772,              802,           812,              817,       885,        960,             966,       1033,     1053,     1063,   1067,   1075,     1076,    1078,    1084,    1087,      1089,       1092,     1095,       1106,        1109,        1125,             1146,        1160,               1213,        1223,              1264,              1293,                 1297,            1300,           1301,            1302,           1304,           1305,         1306,        1307,        1308,             1357,          1386,           1438,         1477,            1525,             1546,              1566,              1579,            1586,            1594,            1599,            1603,               1607,           1610,               1615,               1619,         1621,             1622,        1628,        1631,       1637,       1637,       1638,         1653,          1658,          1660,           1682);
my @end_off   = (      0,           0,           0,             0,                21,               82,                0,                0,                 0,           0,            0,         0,             0,             0,            0,            0,              0,              0,        0,             0,           0,           0,        0,                0,             0,                0,         0,          0,               0,          0,        0,        0,      0,      0,        0,       0,       0,       0,         0,          0,        0,          0,           0,           0,                0,           0,                  0,           0,                 0,                 0,                    0,               0,              0,               0,              0,              0,            0,           0,           0,                0,             0,              0,            0,               0,                0,                 0,                 0,               0,               0,               0,               0,                  0,              0,                  0,                  0,            0,                0,           0,           0,          0,          0,          0,            0,             0,             0,              0);

my $outfolder = "01_out/";
my $infolder  = "../TEXT/";

system("rm -rf $outfolder");
system("mkdir -p $outfolder");

for ($i = 0; $i < @chapters; $i++)
{
	$chapter           = $chapters[$i];
	$firstpage         = $ch_start[$i];
	$lastpage          = $ch_end[$i];
	
	$first_page_offset = $start_off[$i];
	$last_page_offset  = $end_off[$i];

	$chapter_index = sprintf("%03d", $i);
	
	$outfilename = $outfolder . $chapter_index . "_" . $chapter . ".txt";
	
	printf "Writing $outfilename with pages from $firstpage to $lastpage.\n";
	
	for ($k = $firstpage; $k <= $lastpage; $k++)
	{
		$formatted_number = sprintf("%04d", $k);
		
		$currinfilename = $infolder . "IMG_FILE_" . $formatted_number . "_TEXT.txt";
		
		printf "Adding page $currinfilename.\n";
		
		if (($k == $firstpage) && ($first_page_offset > 0))
		{
			system("tail -n +$first_page_offset $currinfilename > tmp.txt");
			system("cat tmp.txt >> $outfilename");
		}
		elsif (($k == $lastpage) && ($last_page_offset > 0))
		{
			system("head -n -$last_page_offset $currinfilename > tmp.txt");
			system("cat tmp.txt >> $outfilename");
		}
		else
		{
			system("cat $currinfilename >> $outfilename");
		}
		
		if ($k < $lastpage)
		{
			system("echo >> $outfilename");	
			system("echo ----------------------------------- https://digital.slub-dresden.de/data/kitodo/BibltojeZ_478590679/BibltojeZ_478590679_tif/jpegs/0000$formatted_number.tif.large.jpg ----------------------------------------------------------- >> $outfilename");	
			system("echo >> $outfilename");	
		}
	}
}
