* 10/05/18;
LIBNAME kiditem '/folders/myfolders';

PROC IMPORT datafile = '/folders/myfolders/chartevents_kidney.csv' OUT = work.chartevents 
DBMS = CSV REPLACE;
RUN;

PROC IMPORT datafile = '/folders/myfolders/d_items.csv' OUT = work.items
DBMS = CSV REPLACE;
RUN;

data items_systolic;
   set chartevents;
   if index(upcase(label),upcase("systolic"))>0;
run;

/* Ventilators */

** itemid 720 "ventilator mode";
data item720 (where=(itemid=720));
set chartevents; run;
proc sort data=item720;
by subject_id itemid; run;
proc sort data=item720 NODUPKEY out=item720nd;
by subject_id; run;
proc print data=item720; run;
* empty valuenum, character data;
proc print data=item720nd; run;

** 721 "ventilator No.";
data item721 (where=(itemid=721));
set chartevents; run;
proc sort data=item721;
by subject_id itemid; run;
proc sort data=item721 NODUPKEY out=item721nd;
by subject_id; run;
proc print data=item721; run;
* 163 observations in chartevents;
* 11 unique subjects;
proc univariate data=item721;run;
* 10-90% range: 1-14;
proc print data=item721nd; run;


** 722 "ventilator type";
data item722 (where=(itemid=722));
set chartevents; run;
proc sort data=item722;
by subject_id itemid; run;
proc sort data=item722 NODUPKEY out=item722nd;
by subject_id; run;
proc print data=item722; run;
* 2684 observations in chartevents;
* empty valueunm;
proc print data=item722nd; run;
* 63 unique subjects;

** 3681 "ventilator number";
data item3681 (where=(itemid=3681));
set chartevents; run;
* None in chartevents;

** 3689 "ventilator[Vt]";
data item3689 (where=(itemid=3689));
set chartevents; run;
* None in chartevents;

** 227565 "ventilator tank 1" meaning Ventilator Tank #1;
data item227565 (where=(itemid=227565));
set chartevents; run;
proc sort data=item227565;
by subject_id itemid; run;
proc sort data=item227565 NODUPKEY out=item227565nd;
by subject_id; run;
proc print data=item227565; run;
* 594 observations in chartevents;
proc univariate data=item227565;run;
*Basic Statistical Measures
Location	Variability
Mean	1863.806	Std Deviation	590.41112
Median	1800.000	Variance	348585
Mode	2000.000	Range	2100
 	 	Interquartile Range	800.00000;
* 10-90%: 1200 to 2900;
proc print data=item227565nd; run;
* 39 unique subjects;

** 227566 "ventilator tank 2" meaning Ventilator Tank #2;
data item227566 (where=(itemid=227566));
set chartevents; run;
proc sort data=item227566;
by subject_id itemid; run;
proc sort data=item227566 NODUPKEY out=item227566nd;
by subject_id; run;
proc print data=item227566; run;
* 596 observations in chartevents;
proc univariate data=item227566;run;
* Basic Statistical Measures
Location	Variability
Mean	1927.685	Std Deviation	555.30021
Median	1800.000	Variance	308358
Mode	2000.000	Range	2000
 	 	Interquartile Range	900.00000;
* 10-90%: 1200 to 2800;
proc print data=item227566nd; run;
* 39 unique subjects;

** 223848 ventilator type;
data item223848 (where=(itemid=223848));
set chartevents; run;
proc print data=item223848; run;
* 1459 observations in chartevents;
proc sort data=item223848;
by subject_id itemid; run;
proc sort data=item223848 NODUPKEY out=item223848nd;
by subject_id; run;
proc print data=item223848nd; run;
* 50 unique subjects;
proc univariate data=item223848; run;
* interquartile range 0, from 1 to 1;

** 223849 ventilator mode;
data item223849 (where=(itemid=223849));
set chartevents; run;
proc print data=item223849; run;
* 1648 observations in chartevents;
proc sort data=item223849;
by subject_id itemid; run;
proc sort data=item223849 NODUPKEY out=item223849nd;
by subject_id; run;
proc print data=item223849nd; run;
* 51 unique subjects;
proc univariate data=item223849; run;
* 10-90% range: from 11 to 49;

** 223849 ventilator mode;
data item223849 (where=(itemid=223849));
set chartevents; run;
proc print data=item223849; run;
* 1648 observations in chartevents;
proc sort data=item223849;
by subject_id itemid; run;
proc sort data=item223849 NODUPKEY out=item223849nd;
by subject_id; run;
proc print data=item223849nd; run;
* 51 unique subjects;
proc univariate data=item223849; run;
* 10-90% range: from 11 to 49;


/* intubation */

** 226814 "Known difficult intubation";
data item226814 (where=(itemid=226814));
set chartevents; run;
* 896 observations, empty valuenum;
proc sort data=item226814;
by subject_id itemid; run;
proc sort data=item226814 NODUPKEY out=item226814nd;
by subject_id; run;
proc print data=item226814nd; run;
* 31 unique subjects;

** All the other itemids not found in chartevents;


/* dialysis */

proc freq data=chartevents;
tables itemid; run;

* 148 149 150 151 152 224144 224145 224146 224149 224150 
224151 224152 224153 224154 224191 224404 224406 225126 
225183 225323 225976 225977 226118 226457 227124 227290 
227357 227753 228004 228005 228006 exist in chartevents;

** 148 Dialysis Access Site;
data item148 (where=(itemid=148));
set chartevents; run;
proc print data=item148; run;
* 923 observations in chartevents;
* empty valuenum;
proc sort data=item148;
by subject_id itemid; run;
proc sort data=item148 NODUPKEY out=item148nd;
by subject_id; run;
proc print data=item148nd; run;
* 14 unique subjects;

** 149 Dialysis Access Type;
data item149 (where=(itemid=149));
set chartevents; run;
* 924 observations, empty valuenum;
proc sort data=item149;
by subject_id itemid; run;
proc sort data=item149 NODUPKEY out=item149nd;
by subject_id; run;

** 150 dialysis machine;
data item150 (where=(itemid=150));
set chartevents; run;
* 906 obs, empty valuenum;
proc sort data=item150;
by subject_id itemid; run;
proc sort data=item150 NODUPKEY out=item150nd;
by subject_id; run;

** dialysis site appear;
data item151 (where=(itemid=151));
set chartevents; run;
* 743 obs, empty valuenum;
proc sort data=item151;
by subject_id itemid; run;
proc sort data=item151 NODUPKEY out=item151nd;
by subject_id; run;
* 15 unique;

** dialysis type;
data item152 (where=(itemid=152));
set chartevents; run;
* 1253 obs, empty valuenum;
proc sort data=item152;
by subject_id itemid; run;
proc sort data=item152 NODUPKEY out=item152nd;
by subject_id; run;
* 15 unique;

** 224144 Blood Flow (ml/min);
data item224144 (where=(itemid=224144));
set chartevents; run;
* 1696 obs;
proc sort data=item224144;
by subject_id itemid; run;
proc sort data=item224144 NODUPKEY out=item224144nd;
by subject_id; run;
proc print data=item224144nd; run;
* 18 unique subjects;
proc univariate data=item224144; run;
* Basic Statistical Measures
Location	Variability
Mean	124.8833	Std Deviation	52.37217
Median	120.0000	Variance	2743
Mode	120.0000	Range	2120
 	 	Interquartile Range	0;
* 10-90% range: 0, 120 to 120 mL/min;

** 224145 Heparin Dose (per hour);
data item224145 (where=(itemid=224145));
set chartevents; run;
* 357 obs;
proc sort data=item224145;
by subject_id itemid; run;
proc sort data=item224145 NODUPKEY out=item224145nd;
by subject_id; run;
proc print data=item224145nd; run;
* 14 unique subjects;
proc univariate data=item224145; run;
* Basic Statistical Measures
Location	Variability
Mean	312.7451	Std Deviation	554.72817
Median	0.0000	Variance	307723
Mode	0.0000	Range	1750
 	 	Interquartile Range	600.00000;
*10-90% range 0 to 1350 units;

** 224146 System Integrity;
data item224146 (where=(itemid=224146));
set chartevents; run;
* 2290 obs but empty valuenum;
proc sort data=item224146;
by subject_id itemid; run;
proc sort data=item224146 NODUPKEY out=item224146nd;
by subject_id; run;
proc print data=item224146nd; run;
* 18 unique subjects;

** 224149 	;
data item224149 (where=(itemid=224149));
set chartevents; run;
* 1739 obs;
proc sort data=item224149;
by subject_id itemid; run;
proc sort data=item224149 NODUPKEY out=item224149nd;
by subject_id; run;
proc print data=item224149nd; run;
* 18 unique subjects;
proc univariate data=item224149; run;
*Basic Statistical Measures
Location	Variability
Mean	-47.0535	Std Deviation	38.71330
Median	-41.0000	Variance	1499
Mode	-24.0000	Range	1190
 	 	Interquartile Range	33.00000;
* 10-90%: -77 to -17 mmHg;

** 224150 Filter pressure;
data item224150 (where=(itemid=224150));
set chartevents; run;
* 1738 obs;
proc sort data=item224150;
by subject_id itemid; run;
proc sort data=item224150 NODUPKEY out=item224150nd;
by subject_id; run;
* 18 unique subjects;
proc print data=item224150nd; run;
proc univariate data=item224150; run;
* Basic Statistical Measures
Location	Variability
Mean	116.1525	Std Deviation	39.93451
Median	112.0000	Variance	1595
Mode	100.0000	Range	1052
 	 	Interquartile Range	41.00000;
* 10-90%: 79 to 155 mmHg;

** 224151 Effluent Pressure;
data item224151 (where=(itemid=224151));
set chartevents; run;
* 1737 obs;
proc sort data=item224151;
by subject_id itemid; run;
proc sort data=item224151 NODUPKEY out=item224151nd;
by subject_id; run;
* 18 unique;
proc univariate data=item224151; run;
* Basic Statistical Measures
Location	Variability
Mean	-14.5210	Std Deviation	46.63200
Median	-7.0000	Variance	2175
Mode	0.0000	Range	453.00000
 	 	Interquartile Range	44.00000;
* 10-90: -66 to 32 mmHg;

** 224152 Return pressure;
data item224152 (where=(itemid=224152));
set chartevents; run;
* 1737 obs;
proc sort data=item224152;
by subject_id itemid; run;
proc sort data=item224152 NODUPKEY out=item224152nd;
by subject_id; run;
* 18 unique;
proc univariate data=item224152; run;
* Basic Statistical Measures
Location	Variability
Mean	58.26885	Std Deviation	26.43882
Median	57.00000	Variance	699.01120
Mode	53.00000	Range	317.00000
 	 	Interquartile Range	36.00000;
* 10-90%: 27 to 90 mmHg;

** 224153 Replacement pressure;
data item224153 (where=(itemid=224153));
set chartevents; run;
* 1815 obs;
proc sort data=item224153;
by subject_id itemid; run;
proc sort data=item224153 NODUPKEY out=item224153nd;
by subject_id; run;
* 18 unique;
proc univariate data=item224153; run;
* Basic Statistical Measures
Location	Variability
Mean	1860.992	Std Deviation	536.52595
Median	2000.000	Variance	287860
Mode	2000.000	Range	4000
 	 	Interquartile Range	500.00000;
* 10-90%: 1500 to 2200 mL/h;

** 224154 Dialysate Rate;
data item224154 (where=(itemid=224154));
set chartevents; run;
* 1810 obs;
proc sort data=item224154;
by subject_id itemid; run;
proc sort data=item224154 NODUPKEY out=item224154nd;
by subject_id; run;
* 18 unique;
proc univariate data=item224154; run;
* Basic Statistical Measures
Location	Variability
Mean	447.0718	Std Deviation	194.73371
Median	500.0000	Variance	37921
Mode	500.0000	Range	1000
 	 	Interquartile Range	0;
* 10-90%: 0 to 500 mL/h;

** 224191 Hourly Patient Fluid Removal;
data item224191 (where=(itemid=224191));
set chartevents; run;
* 1881 obs;
proc sort data=item224191;
by subject_id itemid; run;
proc sort data=item224191 NODUPKEY out=item224191nd;
by subject_id; run;
* 18 unique;
proc univariate data=item224191; run;
*Basic Statistical Measures
Location	Variability
Mean	401.2701	Std Deviation	147.56403
Median	400.0000	Variance	21775
Mode	400.0000	Range	1000
 	 	Interquartile Range	200.00000;
* 10-90%: 250 to 600 mL;

** 224404 ART Lumen Volume;
data item224404 (where=(itemid=224404));
set chartevents; run;
* 458 obs;
proc sort data=item224404;
by subject_id itemid; run;
proc sort data=item224404 NODUPKEY out=item224404nd;
by subject_id; run;
* 12 unique;
proc univariate data=item224404; run;
* Basic Statistical Measures
Location	Variability
Mean	1.612664	Std Deviation	0.46952
Median	1.500000	Variance	0.22045
Mode	1.500000	Range	1.40000
 	 	Interquartile Range	0.70000;
* 10-90%: 1 to 2.4 mL;

* 224406 VEN Lumen Volume;
data item224406 (where=(itemid=224406));
set chartevents; run;
* 458 obs;
proc sort data=item224406;
by subject_id itemid; run;
proc sort data=item224406 NODUPKEY out=item224406nd;
by subject_id; run;
* 12 unique;
proc univariate data=item224406; run;
*Basic Statistical Measures
Location	Variability
Mean	1.694323	Std Deviation	0.40744
Median	1.600000	Variance	0.16601
Mode	2.300000	Range	1.20000
 	 	Interquartile Range	0.70000;
* 10-90%: 1.2 to 2.3 mL;

** 225126 Dialysis patient;
data item225126 (where=(itemid=225126));
set chartevents; run;
* 282 obs;
proc sort data=item225126;
by subject_id itemid; run;
proc sort data=item225126 NODUPKEY out=item225126nd;
by subject_id; run;
* 104 unique;
proc univariate data=item225126; run;
* Basic Statistical Measures
Location	Variability
Mean	0.177305	Std Deviation	0.38261
Median	0.000000	Variance	0.14639
Mode	0.000000	Range	1.00000
 	 	Interquartile Range	0;
* 10-90%: 0 to 1;

** 225183 Current goal;
data item225183 (where=(itemid=225183));
set chartevents; run;
* 1758 obs;
proc sort data=item225183;
by subject_id itemid; run;
proc sort data=item225183 NODUPKEY out=item225183nd;
by subject_id; run;
* 18 unique;
proc univariate data=item225183;run;
*Basic Statistical Measures
Location	Variability
Mean	-49.8589	Std Deviation	270.74728
Median	-50.0000	Variance	73304
Mode	0.0000	Range	10500
 	 	Interquartile Range	100.00000;
*10-90%: -20 to 50;

** 225323 Dialysis Catheter Site Appear;
data item225323 (where=(itemid=225323));
set chartevents; run;
* 1269 obs, but empty valuenum, character values;
proc sort data=item225323;
by subject_id itemid; run;
proc sort data=item225323 NODUPKEY out=item225323nd;
by subject_id; run;
* 42 unique;

** 225976 Replacement Fluid;
data item225976 (where=(itemid=225976));
set chartevents; run;
* 1764 obs but character values;
proc sort data=item225976;
by subject_id itemid; run;
proc sort data=item225976 NODUPKEY out=item225976nd;
by subject_id; run;
* 18 unique;

** 225977 Dialysate Fluid;
data item225977 (where=(itemid=225977));
set chartevents; run;
* 1765 obs but character values;
proc sort data=item225977;
by subject_id itemid; run;
proc sort data=item225977 NODUPKEY out=item225977nd;
by subject_id; run;
* 18 unique;

** 226118 Dialysis Catheter placed in outside facility;
data item226118 (where=(itemid=226118));
set chartevents; run;
* 1079 obs;
proc sort data=item226118;
by subject_id itemid; run;
proc sort data=item226118 NODUPKEY out=item226118nd;
by subject_id; run;
* 42 unique;
proc univariate data=item226118; run;
* Basic Statistical Measures
Location	Variability
Mean	0.015755	Std Deviation	0.12459
Median	0.000000	Variance	0.01552
Mode	0.000000	Range	1.00000
 	 	Interquartile Range	0;
* 10-90%: 0 to 0;

** 226457 Ultrafiltrate Output;
data item226457 (where=(itemid=226457));
set chartevents; run;
* 2021 obs;
proc sort data=item226457;
by subject_id itemid; run;
proc sort data=item226457 NODUPKEY out=item226457nd;
by subject_id; run;
* 21 unique;
proc univariate data=item226457; run;
* Basic Statistical Measures
Location	Variability
Mean	395.2108	Std Deviation	243.19042
Median	384.0000	Variance	59142
Mode	0.0000	Range	5037
 	 	Interquartile Range	174.00000;
* 10-90%: 220 to 571 mL;

** 227124 Dialysis Catheter Type;
data item227124 (where=(itemid=227124));
set chartevents; run;
* 996 obs but character values;
proc sort data=item227124;
by subject_id itemid; run;
proc sort data=item227124 NODUPKEY out=item227124nd;
by subject_id; run;
* 38 unique;

** 227290 CRRT mode;
data item227290 (where=(itemid=227290));
set chartevents; run;
* 1064 obs but character values;
proc sort data=item227290;
by subject_id itemid; run;
proc sort data=item227290 NODUPKEY out=item227290nd;
by subject_id; run;
* 18 unique;

** 227357 Dialysis Catheter Dressing Occlusive;
data item227357 (where=(itemid=227357));
set chartevents; run;
* 1151 obs but character values;
proc sort data=item227357;
by subject_id itemid; run;
proc sort data=item227357 NODUPKEY out=item227357nd;
by subject_id; run;
* 41 unique;

** 227753 Dialysis Catheter Placement Confirmed by X-ray;
data item227753 (where=(itemid=227753));
set chartevents; run;
* 806 obs and character;
proc sort data=item227753;
by subject_id itemid; run;
proc sort data=item227753 NODUPKEY out=item227753nd;
by subject_id; run;
* 31 unique;

** 228004 Citrate (ACD-A);
data item228004 (where=(itemid=228004));
set chartevents; run;
* 1524 obs;
proc sort data=item228004;
by subject_id itemid; run;
proc sort data=item228004 NODUPKEY out=item228004nd;
by subject_id; run;
* 14 unique;
proc univariate data=item228004; run;
* Basic Statistical Measures
Location	Variability
Mean	163.5400	Std Deviation	68.20861
Median	180.0000	Variance	4652
Mode	180.0000	Range	1800
 	 	Interquartile Range	0;
* 10-90%: 150 to 180 mL/h;

** 228005 PBP (Prefilter) Replacement Rate;
data item228005 (where=(itemid=228005));
set chartevents; run;
* 1508 obs;
proc sort data=item228005;
by subject_id itemid; run;
proc sort data=item228005 NODUPKEY out=item228005nd;
by subject_id; run;
* 14 unique;
proc univariate data=item228005; run;
* Basic Statistical Measures
Location	Variability
Mean	1679.629	Std Deviation	468.55791
Median	1600.000	Variance	219547
Mode	1800.000	Range	3300
 	 	Interquartile Range	300.00000;
* 10-90%: 1200 to 2000 mL/h;

** 228006 Post Filter Replacement Rate;
data item228006 (where=(itemid=228006));
set chartevents; run;
* 1491 obs;
proc sort data=item228006;
by subject_id itemid; run;
proc sort data=item228006 NODUPKEY out=item228006nd;
by subject_id; run;
* 14 unique;
proc univariate data=item228006; run;
*Basic Statistical Measures
Location	Variability
Mean	256.1033	Std Deviation	159.63352
Median	200.0000	Variance	25483
Mode	200.0000	Range	1000
 	 	Interquartile Range	0
Tests for Location: Mu0=0;
* 10-90%: 200 to 500 mL/h;

** 225952 Medication Added #1 (Peritoneal Dialysis);

data item225952 (where=(itemid=225952));
set chartevents; run;
* one obs and no value;

** 225953 Solution (Peritoneal Dialysis);
data item225953 (where=(itemid=225953));
set chartevents; run;
* one obs only;


/* Radial arterial blood pressure */
** All the other itemid including 2769, 2770, 5679 and 5980 are not found in chartevents;

** 603 radial pulse [right];
data item603 (where=(itemid=603));
set chartevents; run;
* 58 obs but character values;
proc sort data=item603;
by subject_id itemid; run;
proc sort data=item603 NODUPKEY out=item603nd;
by subject_id; run;
* 5 unique;

** 223936 Radial Pulse R;
data item223936 (where=(itemid=223936));
set chartevents; run;
* 790 obs but character values;
proc sort data=item223936;
by subject_id itemid; run;
proc sort data=item223936 NODUPKEY out=item223936nd;
by subject_id; run;
* 87 unique;

** 223948 Radial Pulse L;
data item223948 (where=(itemid=223948));
set chartevents; run;
* 779 obs but character values;
proc sort data=item223948;
by subject_id itemid; run;
proc sort data=item223948 NODUPKEY out=item223948nd;
by subject_id; run;
* 87 unique;


/* Non-invasive */
** 225794 not found in chartevents;

** 223751 Non-Invasive Blood Pressure Alarm - High;
data item223751 (where=(itemid=223751));
set chartevents; run;
* 1229 obs;
proc sort data=item223751;
by subject_id itemid; run;
proc sort data=item223751 NODUPKEY out=item223751nd;
by subject_id; run;
* 170 unique;
proc univariate data=item223751; run;
* Basic Statistical Measures
Location	Variability
Mean	159.5403	Std Deviation	122.70720
Median	160.0000	Variance	15057
Mode	160.0000	Range	4085
 	 	Interquartile Range	0;
* 10-90%: 110 to 160 mmHg;

** 223752 Non-Invasive Blood Pressure Alarm - Low;
data item223752 (where=(itemid=223752));
set chartevents; run;
* 1229 obs;
proc sort data=item223752;
by subject_id itemid; run;
proc sort data=item223752 NODUPKEY out=item223752nd;
by subject_id; run;
* 170 unique;
proc univariate data=item223752; run;
*Basic Statistical Measures
Location	Variability
Mean	85.98291	Std Deviation	10.93163
Median	90.00000	Variance	119.50052
Mode	90.00000	Range	120.00000
 	 	Interquartile Range	0;
* 10-90%: 65 to 90 mmHg;

** 220179 Non invasive blood pressure systolic ;
data item220179 (where=(itemid=220179));
set chartevents; run;
* 10552 obs;
proc sort data=item220179;
by subject_id itemid; run;
proc sort data=item220179 NODUPKEY out=item220179nd;
by subject_id; run;
* 169 unique;
proc univariate data=item220179; run;
*Basic Statistical Measures
Location	Variability
Mean	118.5161	Std Deviation	25.18986
Median	115.0000	Variance	634.52898
Mode	108.0000	Range	200.00000
 	 	Interquartile Range	35.00000;
* 10-90%: 89 to 153 mmHg;

** 220180 Non invasive blood pressure diastolic;
data item220180 (where=(itemid=220180));
set chartevents; run;
* 10546 obs;
proc sort data=item220180;
by subject_id itemid; run;
proc sort data=item220180 NODUPKEY out=item220180nd;
by subject_id; run;
* 169 unique;
proc univariate data=item220180; run;
*Basic Statistical Measures
Location	Variability
Mean	61.21970	Std Deviation	16.11405
Median	59.50000	Variance	259.66258
Mode	59.00000	Range	191.00000
 	 	Interquartile Range	21.00000;
* 10-90%: 42.0 to 82.0 mmHg;

** 220181 Non invasive blood pressure mean;
data item220181 (where=(itemid=220181));
set chartevents; run;
* 10581 obs;
proc sort data=item220181;
by subject_id itemid; run;
proc sort data=item220181 NODUPKEY out=item220181nd;
by subject_id; run;
* 169 unique;
proc univariate data=item220181; run;
*Basic Statistical Measures
Location	Variability
Mean	74.75465	Std Deviation	17.15268
Median	73.00000	Variance	294.21428
Mode	63.00000	Range	189.00000
 	 	Interquartile Range	22.00000;
* 10-90%: 55 to 97 mmHg;

/* albumin */
** 772 Albumin (>3.2);
data item772 (where=(itemid=772));
set chartevents; run;
* 256 obs;
proc sort data=item772;
by subject_id itemid; run;
proc sort data=item772 NODUPKEY out=item772nd;
by subject_id; run;
* 110 unique;
proc univariate data=item772; run;
*Basic Statistical Measures
Location	Variability
Mean	2.755469	Std Deviation	0.62826
Median	2.700000	Variance	0.39472
Mode	2.900000	Range	3.40000
 	 	Interquartile Range	0.80000;
* 10-90%: 2.0 to 3.6;

** 1521 Albumin ;
data item1521 (where=(itemid=1521));
set chartevents; run;
* 214 obs;
proc sort data=item1521;
by subject_id itemid; run;
proc sort data=item1521 NODUPKEY out=item1521nd;
by subject_id; run;
* 87 unique;
proc univariate data=item1521; run;
*Basic Statistical Measures
Location	Variability
Mean	2.797664	Std Deviation	0.64724
Median	2.700000	Variance	0.41891
Mode	2.900000	Range	3.40000
 	 	Interquartile Range	0.80000;
* 10-90%: 2.0 to 3.6;

** 226981 Albumin_ApacheIV;
* only 1 obs;

** 226982 AlbuminScore_ApacheIV;
* only 1 obs;

** 227456 Albumin ;
data item227456 (where=(itemid=227456));
set chartevents; run;
* 275 obs;
proc sort data=item227456;
by subject_id itemid; run;
proc sort data=item227456 NODUPKEY out=item227456nd;
by subject_id; run;
* 108 unique;
proc univariate data=item227456; run;
*Basic Statistical Measures
Location	Variability
Mean	3.022545	Std Deviation	0.67845
Median	3.000000	Variance	0.46029
Mode	3.000000	Range	4.00000
 	 	Interquartile Range	0.80000;
* 10-90%: 2.2 to 3.9;


/* arterial pH*/

** 780 arterial pH;
data item780 (where=(itemid=780));
set chartevents; run;
* 1229 obs;
proc sort data=item780;
by subject_id itemid; run;
proc sort data=item780 NODUPKEY out=item780nd;
by subject_id; run;
* 107 unique;
proc univariate data=item780; run;
* Basic Statistical Measures
Location	Variability
Mean	7.350489	Std Deviation	0.09123
Median	7.360000	Variance	0.00832
Mode	7.360000	Range	0.90000
 	 	Interquartile Range	0.11000;
* 10-90%: 7.24 to 7.45;


/* venous pH */
** 860 venous pH;
data item860 (where=(itemid=860));
set chartevents; run;
* 106 obs;
proc sort data=item860;
by subject_id itemid; run;
proc sort data=item860 NODUPKEY out=item860nd;
by subject_id; run;
* 48 unique;
proc univariate data=item860; run;
* Basic Statistical Measures
Location	Variability
Mean	7.310385	Std Deviation	0.09444
Median	7.300000	Variance	0.00892
Mode	7.270000	Range	0.40000
 	 	Interquartile Range	0.14500;
* 10-90%: 7.18 to 7.43;

** 3777 mixed venous pH;
* none in chartevents;


/* platelets */

** 828 platelets;
data item828 (where=(itemid=828));
set chartevents; run;
* 12569 obs;
proc sort data=item828;
by subject_id itemid; run;
proc sort data=item828 NODUPKEY out=item828nd;
by subject_id; run;
* 166 unique;
proc univariate data=item828; run;
* Basic Statistical Measures
Location	Variability
Mean	191.8235	Std Deviation	131.36727
Median	163.5000	Variance	17257
Mode	125.0000	Range	1056
 	 	Interquartile Range	156.00000;
* 10-90%: 60 to 359;


** 227457 platelet counts;
data item227457 (where=(itemid=227457));
set chartevents; run;
* 1173 obs; 
proc sort data=item227457;
by subject_id itemid; run;
proc sort data=item227457 NODUPKEY out=item227457nd;
by subject_id; run;
* 191 unique;
proc univariate data=item227457; run;
* Basic Statistical Measures
Location	Variability
Mean	191.7255	Std Deviation	142.28413
Median	157.0000	Variance	20245
Mode	81.0000	Range	1066
 	 	Interquartile Range	179.00000;
* 10-90%: 56 to 363 K/uL;


/* bilirubin */

** 225651 Direct bilirubin;
data item225651 (where=(itemid=225651));
set chartevents; run;
* 52 obs; 
proc sort data=item225651;
by subject_id itemid; run;
proc sort data=item225651 NODUPKEY out=item225651nd;
by subject_id; run;
* 21 unique;
proc univariate data=item225651; run;
* Basic Statistical Measures
Location	Variability
Mean	6.719231	Std Deviation	6.58048
Median	3.850000	Variance	43.30276
Mode	0.700000	Range	19.10000
 	 	Interquartile Range	11.95000;
* 10-90%: 0.7 to 17.8 mg/d;

** 225690 Total bilirubin;

data item225690 (where=(itemid=225690));
set chartevents; run;
* 496 obs; 
proc sort data=item225690;
by subject_id itemid; run;
proc sort data=item225690 NODUPKEY out=item225690nd;
by subject_id; run;
* 134 unique;
proc univariate data=item225690; run;
* Basic Statistical Measures
Location	Variability
Mean	4.947581	Std Deviation	7.07087
Median	1.400000	Variance	49.99717
Mode	0.200000	Range	28.50000
 	 	Interquartile Range	5.75000;
* 10-90%: 0.2 to 17.8 mg/d;


proc freq data=chartevents;
tables itemid;
run;



