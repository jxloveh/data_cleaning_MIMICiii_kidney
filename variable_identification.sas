* 10/05/18;
LIBNAME kidney '/folders/myfolders';

PROC IMPORT datafile = '/folders/myfolders/chartevents_kidney.csv' OUT = work.chartevents 
DBMS = CSV REPLACE;
RUN;

PROC IMPORT datafile = '/folders/myfolders/d_items.csv' OUT = work.items
DBMS = CSV REPLACE;
RUN;

PROC IMPORT datafile = '/folders/myfolders/labevents_kidney.csv' OUT = work.labevents 
DBMS = CSV REPLACE;
RUN;


** ventilator;
data items_ventilator;
   set items;
   if index(upcase(label),upcase("ventilator"))>0;
run;

proc freq data = chartevents (where = (itemid IN (720, 721, 722, 3681, 3689, 
227565, 227566, 223848, 223849, 13977)));
table itemid;
run;
* have observations: 720, 721, 722, 227565, 227566, 223848, 223849;
* 3681, 3689, 13977 have no observations;

DATA sub_ventilator (WHERE=(itemid IN (720, 721, 722, 227565, 227566, 223848, 223849)));
SET chartevents;
RUN;
PROC SORT DATA=sub_ventilator;
BY icustay_id charttime;
RUN;
PROC SORT DATA=sub_ventilator NODUPKEY out=sub_ventilator1;
BY icustay_id;
RUN;
PROC SORT DATA=sub_ventilator1;
by subject_id;
* a subject_id can have multiple icustay_id;
proc print data=sub_ventilator1;
run;
* 120 rows;
PROC SORT DATA=sub_ventilator1 nodupkey out=sub_Ventilator2;
BY subject_id;
RUN;
* 111 rows - 9 dupe rows were deleted;


** intubation;
data items_intubation;
   set items;
   if index(upcase(label),upcase("intubation"))>0;
run;
proc freq data = chartevents (where = (itemid IN (418, 227210, 227211, 227212, 
227213, 227214, 227215, 226814, 226843, 222871, 223059, 225585, 225586, 225587, 
225577, 225590, 225592, 225593, 224385, 226166, 226188, 226191, 225271, 226430, 
226431, 226432, 228067, 228068, 228069, 225291, 225294, 225295, 225296, 225297, 
225298, 225300, 225301, 225302, 225303, 225304, 225306)));
table itemid;
run;
* only 226814 has observations in chartevents;
* no obs: 418, 227210, 227211, 227212, 227213, 227214, 227215, 226843, 222871, 
223059, 225585, 225586, 225587, 225577, 225590, 225592, 225593, 224385, 226166, 
226188, 226191, 225271, 226430, 226431, 226432, 228067, 228068, 228069, 225291,
225294, 225295, 225296, 225297, 225298, 225300, 225301, 225302, 225303, 225304, 225306;

data sub_intubation (where=(itemid=226814));
set chartevents; run;
proc sort data=sub_intubation;
by subject_id icustay_id charttime; run;
proc sort data=sub_intubation nodupkey out=sub_intubation1;
by subject_id; run;
* 31 rows;


** dialysis;
data items_dialysis;
   set items;
   if index(upcase(label),upcase("dialysis"))>0;
run;
proc freq data = chartevents (where = (itemid IN (
148, 149, 150, 151, 152, 40425, 40507, 41527, 41250, 41374, 41417, 40881, 41910, 
41016, 41034, 42289, 42388, 42524, 42536, 40386, 41635, 41842, 40624, 40690, 41500,
43941, 44199, 44901, 42928, 42972, 43016, 43052, 43098, 44567, 46394, 46741, 40745, 
44843, 43687, 45479, 46230, 46232, 46712, 46715, 44027, 44085, 44193, 44216, 44286, 
45828, 46464, 42868, 43115, 41750, 41829, 40426, 40613, 227124, 44845, 44857, 42464,
224270, 225441, 224135, 224139, 227357, 227753, 225802, 225803, 225805, 225809, 225810, 40745)));
table itemid;
run;
* 11/06/18;
proc freq data = chartevents (where=(itemid IN (229,235,241,247,253,259,265,271)));
table itemid;
run;
data dia_1 (where=(itemid IN (229,235,241,247,253,259,265,271)));
set chartevents;
run;
data dia_2 (where=(value = 'Dialysis Line'));
set dia_1;
run;
proc sort data=dia_2;
by subject_id charttime;
run;
proc sort data=dia_2 nodupkey out=dia_3;
by subject_id;
run;
* 44 subjects;

proc freq data = chartevents (where=(itemid IN (466, 927, 6250, 917)));
* 6250 null;
table itemid;
run;
data dia_4 (where=(itemid IN (466, 927, 917)));
set chartevents;
run;
data dia_5 (where=(value LIKE 'Dial%'));
set dia_4;
run;
* search result: itemid 466 has one subject_id - 4 observations;

data dia_6 (where=(itemid IN (582)));
set chartevents;
run;
* frequency: 877;
data dia_7 (where=(value in 
('CAVH Start','CAVH D/C','CVVHD Start','CVVHD D/C','Hemodialysis st','Hemodialysis end')));
set dia_6;
run;
proc sort data=dia_7;
by subject_id charttime;
run;
proc sort data=dia_7 nodupkey out=dia_8;
by subject_id;
run;
* 186 observations from 41 subjects;

proc freq data = chartevents (where=(itemid IN (40788, 40907, 41063, 41147, 41307, 
41460, 41620, 41711, 41791, 41792, 42562, 43829, 44037, 44188, 44526, 44527, 44584, 
44591, 44698, 44927, 44954, 45157 , 45268, 45352, 45353, 46012, 46013, 46172, 46173,
46250, 46262, 46292, 46293, 46311, 46389, 46574, 46681, 46720, 46769, 46773, 40789, 
41069, 41112, 41623, 41713, 41897, 44943, 227536, 227525)));
table itemid;
run;







* starting 10/26/18;
* The outcomes should happen at least 12 hours after admittime from admission table;
* Thus, the independent variables such as bp should exist until the current value (most recent value as of 12 hr after icu admittime);
* This program is about one of our outcomes, ventilator.;

LIBNAME kidney '/folders/myfolders';

PROC IMPORT datafile = '/folders/myfolders/chartevents_kidney.csv' OUT = work.chartevents 
DBMS = CSV REPLACE;
RUN;

PROC IMPORT datafile = '/folders/myfolders/icustays_kidney.csv' OUT = work.icustays
DBMS = CSV REPLACE;
RUN;

PROC IMPORT datafile = '/folders/myfolders/d_items.csv' OUT = work.d_items
DBMS = CSV REPLACE;
RUN;

proc sort data=chartevents out=x1;
by hadm_id;
run;

proc sort data=chartevents out=x2;
by hadm_id;
run;

data x;
   merge x1(in=a) x2(in=b keep=hadm_id);
   by hadm_id;
   if a;
run;

proc sort data=x;
by itemid;
run;

proc sort data=d_items out=y;
by itemid;
run;

* merge chartevents and d_items;
* select only ventilator variables for now - ventilator1 and ventialtor2;

data z;
merge x(in=a) y(in=b keep=itemid label);
by itemid;
if a and b;
if itemid IN(720 721 722 227565 227566 223848 223849);
if valuenum <> 0;
run;

proc sort data=z;
by icustay_id;
run;

proc print data=z ;
run;

* icustay table;

data icustays (keep=subject_id hadm_id icustay_id intime);
set icustays;
run;

proc sort data=icustays;
by subject_id intime;
run;

proc sort data=icustays nodupkey out=icu;
by subject_id;
run;

proc sort data=icu;
by icustay_id; run;
* 339;

data ventilator;
merge z(in=a) icu(in=b);
by icustay_id;
if itemid IN(720 721 722 227565 227566 223848 223849)
THEN outcome=1;
ELSE outcome=0;
run;
* 378;

proc sort data=ventilator out=ventilator nodupkey;
by icustay_id;
run;
* 349;

data ventilator(keep=icustay_id itemid label valuenum intime charttime outcome);
set ventilator;
run;

data timeintck ;
set ventilator;
timediff = intck('minute', intime, charttime);
run;

proc print data=timeintck;
run;

DATA lessthantwelve;
SET timeintck;
BY icustay_id;
ARRAY t{*} timediff;
IF timediff < 720
THEN OUTPUT;
RUN;

proc sort data=lessthantwelve nodupkey out=lessthan12;
by icustay_id;
run;






* Ventilator values >= 12 hours;
* save permanently in the kidney library;

DATA kidney.overtwelve ;
SET timeintck;
BY icustay_id;
ARRAY t{*} timediff;
IF timediff >= 720
THEN OUTPUT;
RUN;

proc sort data=kidney.overtwelve;
by icustay_id timediff;
run;

proc sort data=kidney.overtwelve nodupkey out=over12;
by icustay_id;
run;

* read in a saved table from sas file "102418bp" to merge with a table saved here;
data merged2;
merge kidney.asbp(in=a) kidney.overtwelve(in=b);
if a and b;
by icustay_id;
run;

proc sort data=merged2;
by icustay_id;
run;

proc sort data=merged2 nodupkey out=merged3;
by icustay_id;
run;

proc print daa=merged3;
run;
76, 225963, 225965, 70029, 225725, 225740, 227638, 226118, 225951, 225952, 225953,
225954, 225955, 226499, 225126, 225128, 225318, 225319, 225321, 225322, 225323, 225324)));
table itemid;
* have observations: 148, 149, 150, 151, 152, 225126, 225323, 225725, 225740, 225810, 225951, 
225952, 225953, 225963, 225965, 226118, 226499, 227124, 227357, 227753;
* no obs: 40425, 40507, 41527, 41250, 41374, 41417, 40881, 41910, 41016, 41034, 42289, 
42388, 42524, 42536, 40386, 41635, 41842, 40624, 40690, 41500, 43941, 44199, 44901, 42928, 
42972, 43016, 43052, 43098, 44567, 46394, 46741, 40745, 44843, 43687, 45479, 46230, 46232, 
46712, 46715, 44027, 44085, 44193, 44216, 44286, 45828, 46464, 42868, 43115, 41750, 41829, 
40426, 40613, 44845, 44857, 42464, 224270, 225441, 224135, 224139, 225802, 225803, 225805, 
225809,  225776,  70029, 227638,  225954, 225955,  225128, 225318, 225319, 225321, 225322, 225324;

* excluded 225126 "dialysis patient";
data sub_dialysis (where=(itemid IN (148, 149, 150, 151, 152, 225323, 225725, 225740, 225810, 225951, 
225952, 225953, 225963, 225965, 226118, 226499, 227124, 227357, 227753)));
set chartevents; run;
proc sort data=sub_dialysis;
by subject_id icustay_id charttime; run;
proc sort data=sub_dialysis nodupkey out=sub_dialysis1;
by subject_id; run;
* 65 rows;


** systolic;
data items_systolic;
   set items;
   if index(upcase(label),upcase("systolic"))>0;
run;

proc freq data = chartevents (where = (itemid IN (6, 51, 442, 455, 480, 842, 484, 492, 666, 3313, 3315, 
3317, 3319, 3321, 3323, 3325, 6701, 7643, 220050, 220059, 220179, 224167, 225309, 226850, 226852, 227243, 228152,
1449)));
table itemid;
run;
* have obs: 51, 442, 455, 480, 484, 492, 666, 6701, 220050, 220059, 220179, 224167, 225309, 227243;
* No obs: 6, 482, 3313, 3315, 3317, 3319, 3321, 3323, 3325, 7643, 228152, 226850, 226852 ;

proc freq data = chartevents (where = (itemid IN (51, 442, 455, 480, 484, 492, 666, 6701, 220050, 220059, 220179, 224167, 225309, 227243)));
table itemid;
run;

data sub_systolic (where=(itemid IN (51, 455, 220050, 220179, 442, 225309)));
set chartevents; run;
proc sort data=sub_systolic;
by subject_id ; run;
proc sort data=sub_systolic nodupkey out=sub_systolic1;
by subject_id; run;
* 333 rows;

* arterial systolic;
data sub_systolic (where=(itemid IN (51,442,225309,220050)));
set chartevents; run;
proc sort data=sub_systolic;
by subject_id charttime; run;
proc sort data=sub_systolic nodupkey out=sub_systolic1;
by subject_id; run;
* 128 rows -> 132 rows after adding 442 and 225309;

data item225309 (where=(itemid IN (225309)));
set chartevents; run;
proc sort data=item225309;
by subject_id charttime; run;
proc sort data=item225309 nodupkey out=sub1;
by subject_id; run;
* 128 rows;
proc univariate data=item225309;
run;

data item442 (where=(itemid IN (442)));
set chartevents; run;
proc sort data=item442;
by subject_id charttime; run;
proc sort data=item442 nodupkey out=sub1;
by subject_id; run;
* 128 rows;
proc univariate data=item442;
run;

data item492 (where=(itemid IN (492)));
set chartevents; run;
proc sort data=item492;
by subject_id charttime; run;
proc sort data=item492 nodupkey out=sub1;
by subject_id; run;
* 128 rows;
proc univariate data=item492;
run;

* systoic, non invasive;
data sub_systolic (where=(itemid IN (455, 220050)));
set chartevents; run;
proc sort data=sub_systolic;
by subject_id charttime; run;
proc sort data=sub_systolic nodupkey out=sub_systolic1;
by subject_id ; run;
* 214 rows;



data item51 (where=(itemid=51));
set chartevents; run;
* 10349 obs;
proc sort data=item51;
by subject_id itemid; run;
proc sort data=item51 NODUPKEY out=item51nd;
by subject_id; run;
* 79 unique;
* mmHg;
proc univariate data=item51; run;
*Basic Statistical Measures
Location	Variability
Mean	122.4638	Std Deviation	26.89049
Median	121.0000	Variance	723.09826
Mode	114.0000	Range	283.00000
 	 	Interquartile Range	36.00000;
* 92-158 mmHg;

data item442 (where=(itemid=442));
set chartevents; run;
* 20 obs;
proc sort data=item442;
by subject_id itemid; run;
proc sort data=item442 NODUPKEY out=item442nd;
by subject_id; run;
* 6 unique;
* mmHg;
proc univariate data=item442; run;
*Basic Statistical Measures
Location	Variability
Mean	115.6316	Std Deviation	19.36552
Median	120.0000	Variance	375.02339
Mode	130.0000	Range	72.00000
 	 	Interquartile Range	22.00000;
* 90-130 mmHg;

data item455 (where=(itemid=455));
set chartevents; run;
* 12951 obs;
proc sort data=item455;
by subject_id itemid; run;
proc sort data=item455 NODUPKEY out=item455nd;
by subject_id; run;
* 161 unique;
* mmHg;
proc univariate data=item455; run;
* Basic Statistical Measures
Location	Variability
Mean	120.4039	Std Deviation	24.07415
Median	118.0000	Variance	579.56489
Mode	107.0000	Range	250.00000
 	 	Interquartile Range	33.00000;
* 92-153 mmHg;

data item480 (where=(itemid=480));
set chartevents; run;
* 3 obs;
proc sort data=item480;
by subject_id itemid; run;
proc sort data=item480 NODUPKEY out=item480nd;
by subject_id; run;
* 3 unique;
* mmHg;
proc univariate data=item480; run;
* 9 - 111 mmHg;

data item484 (where=(itemid=484));
set chartevents; run;
* 3 obs;
proc sort data=item484;
by subject_id itemid; run;
proc sort data=item484 NODUPKEY out=item484nd;
by subject_id; run;
* 3 unique;
* mmHg;
proc univariate data=item484; run;
* 98 -146 mmHg;

data item492 (where=(itemid=492));
set chartevents; run;
* 1580 obs;
proc sort data=item492;
by subject_id itemid; run;
proc sort data=item492 NODUPKEY out=item492nd;
by subject_id; run;
* 17 unique;
* mmHg;
proc univariate data=item492; run;
* 33 - 70 mmHg;

data item666 (where=(itemid=666));
set chartevents; run;
* 42 obs;
proc sort data=item666;
by subject_id itemid; run;
proc sort data=item666 NODUPKEY out=item666nd;
by subject_id; run;
* 1 unique;
* %;
proc univariate data=item666; run;
* 1 - 11 %;

data item6701 (where=(itemid=6701));
set chartevents; run;
* 38 obs;
proc sort data=item6701;
by subject_id itemid; run;
proc sort data=item6701 NODUPKEY out=item6701nd;
by subject_id; run;
* 2 unique;
* mmHg;
proc univariate data=item6701; run;
* 87 - 131 mmHg;

data item220050 (where=(itemid=220050));
set chartevents; run;
* 38 obs;
proc sort data=item220050;
by subject_id itemid; run;
proc sort data=item220050 NODUPKEY out=item220050nd;
by subject_id; run;
* 2 unique;
* mmHg;
proc univariate data=item220050; run;
* 92 - 155 mmHg;

data item220059 (where=(itemid=220059));
set chartevents; run;
* 38 obs;
proc sort data=item220059;
by subject_id itemid; run;
proc sort data=item220059 NODUPKEY out=item220059nd;
by subject_id; run;
* 2 unique;
* mmHg;
proc univariate data=item220059; run;
* 23 - 41 mmHg;

data item220179 (where=(itemid=220179));
set chartevents; run;
* 10552 obs;
proc sort data=item220179;
by subject_id itemid; run;
proc sort data=item220179 NODUPKEY out=item220179nd;
by subject_id; run;
* 169 unique;
* mmHg;
proc univariate data=item220179; run;
* 89 - 153 mmHg;



** diastolic;
data items_diastolic;
   set items;
   if index(upcase(label),upcase("diastolic"))>0;
run;

proc freq data = chartevents (where = (itemid IN (153, 8364, 8368, 8440, 8441, 8444, 8445, 8446, 8448,
 8502, 8503, 8504, 8505, 8506, 8507, 8508, 8555, 228151, 227242, 226851, 226853, 224643, 220051, 220060, 220180, 225310
)));
table itemid;
run;
* have obs: 153,  8368, 8440, 8441, 8444, 8445, 8446, 8448, 8555, 227242, 226851, 220060, 220180, 224643, 225310;
* no obs: 8364, 8502, 8503, 8504, 8505, 8506, 8507, 8508, 228151, 226853, 220051;
data sub_diastolic (where=(itemid IN (8368, 8441, 220051, 220180)));
set chartevents; run;
proc sort data=sub_diastolic;
by subject_id icustay_id charttime; run;
proc sort data=sub_diastolic nodupkey out=sub_diastolic1;
by subject_id; run;
* 332 rows;

* diastolic, arterial;
data sub_diastolic (where=(itemid IN (8368, 220051)));
set chartevents; run;
proc sort data=sub_diastolic;
by subject_id icustay_id charttime; run;
proc sort data=sub_diastolic nodupkey out=sub_diastolic1;
by subject_id; run;
* 120 rows;

* diastoilc non invasive;
data sub_diastolic (where=(itemid IN (8441, 220180)));
set chartevents; run;
proc sort data=sub_diastolic;
by subject_id icustay_id charttime; run;
proc sort data=sub_diastolic nodupkey out=sub_diastolic1;
by subject_id; run;
* 328 rows;


data item8368 (where=(itemid=8368));
set chartevents; run;
* 38 obs;
proc sort data=item8368;
by subject_id itemid; run;
proc sort data=item8368 NODUPKEY out=item8368nd;
by subject_id; run;
* 2 unique;
* mmHg;
proc univariate data=item8368; run;
* 23 - 41 mmHg;

data item8441 (where=(itemid=8441));
set chartevents; run;
* 38 obs;
proc sort data=item8441;
by subject_id itemid; run;
proc sort data=item8441 NODUPKEY out=item8441nd;
by subject_id; run;
* 2 unique;
* mmHg;
proc univariate data=item8441; run;
* 23 - 41 mmHg;

data item8448 (where=(itemid=8448));
set chartevents; run;
* 38 obs;
proc sort data=item8448;
by subject_id itemid; run;
proc sort data=item8448 NODUPKEY out=item8448nd;
by subject_id; run;
* 2 unique;
* mmHg;
proc univariate data=item8448; run;
* 23 - 41 mmHg;

data item220051 (where=(itemid=220051));
set chartevents; run;
* 38 obs;
proc sort data=item220051;
by subject_id itemid; run;
proc sort data=item220051 NODUPKEY out=item220051nd;
by subject_id; run;
* 2 unique;
* mmHg;
proc univariate data=item220051; run;
* 23 - 41 mmHg;

data item220180 (where=(itemid=220180));
set chartevents; run;
* 38 obs;
proc sort data=item220180;
by subject_id itemid; run;
proc sort data=item220180 NODUPKEY out=item220180nd;
by subject_id; run;
* 2 unique;
* mmHg;
proc univariate data=item220180; run;
* 23 - 41 mmHg;



** non invasive;
data items_noninvasive;
   set items;
   if index(upcase(label),upcase("non invasive"))>0;
run;

proc freq data = chartevents (where = (itemid IN (220179, 220180, 220181
)));
table itemid;
run;

data items_noninvasive2;
   set items;
   if index(upcase(label),upcase("non-invasive"))>0;
run;

proc freq data = chartevents (where = (itemid IN (223751, 225794, 223752
)));
table itemid;
run;
** have obs: 220179, 220180, 220181, 223751, 223752;
* no obs: 225794;
data sub_noninvasive (where=(itemid IN (220179, 220180, 220181, 223751, 223752)));
set chartevents; run;
proc sort data=sub_noninvasive;
by subject_id icustay_id charttime; run;
proc sort data=sub_noninvasive nodupkey out=sub_noninvasive1;
by subject_id; run;
* 171 rows;


** albumin;
data items_albumin;
   set items;
   if index(upcase(label),upcase("albumin"))>0;
run;

proc freq data = chartevents (where = (itemid IN (772, 3066, 1521, 2358, 3727, 
40548, 30181, 30008, 30009, 44952, 42832, 46564, 44203, 43237, 43353, 226981, 
226982, 227456, 220574, 220861, 220862, 220863, 220864, 45403
)));
table itemid;
run;
* have obs: 772, 1521, 226981, 226982, 227456;
* no obs: 3066,  2358, 3727, 40548, 30181, 30008, 30009, 44952, 42832, 46564, 
44203, 43237, 43353,  220574, 220861, 220862, 220863, 220864, 45403;
data sub_albumin (where=(itemid IN (772, 1521, 226981, 226982, 227456)));
set chartevents; run;
proc sort data=sub_albumin;
by subject_id icustay_id charttime; run;
proc sort data=sub_albumin nodupkey out=sub_albumin1;
by subject_id; run;
* 204 rows;

** bilirubin;
data items_albumin;
   set items;
   if index(upcase(label),upcase("bilirubin"))>0;
run;

proc freq data = chartevents (where = (itemid IN (40885, 4948, 226968, 225651, 225690)));
table itemid;
run;
* have obs: 225651 - direct bilirubin, 225690 - total bilirubin;
* no obs: 40885, 4948, 226968;


data sub_bilirubin (where=(itemid IN (225651, 225690)));
set chartevents; run;
proc sort data=sub_bilirubin;
by subject_id ; run;
proc sort data=sub_bilirubin nodupkey out=sub_bilirubin1;
by subject_id; run;
* 204 rows;


** arterial pH; * added 223830;
data items_arterialph;
   set items;
   if index(upcase(label),upcase("arterial pH"))>0;
run;
proc freq data = chartevents (where = (itemid IN (780, 223830)));
table itemid;
run;

data sub_arterialph (where=(itemid IN (780, 223830)));
set chartevents; run;
proc sort data=sub_arterialph;
by subject_id charttime; run;
proc sort data=sub_arterialph nodupkey out=sub_arterialph1;
by subject_id; run;
* 190 subjects;

data sub_223830(where=(itemid IN (223830)));
set chartevents; run;
proc sort data=sub_223830;
by subject_id; run;
proc sort data=sub_223830 nodupkey out=sub_223820_1;
by subject_id; run;
* 190 subjects;
proc univariate data=sub_223830;
run;

* venous pH;
data items_venousph;
   set items;
   if index(upcase(label),upcase("venous pH"))>0;
run;
proc freq data = chartevents (where = (itemid IN (860, 3777)));
table itemid;
run;
* have obs: 860;
* no obs: 3777;
data sub_venousph (where=(itemid IN (860)));
set chartevents; run;
proc sort data=sub_platelet;
by subject_id icustay_id charttime; run;
proc sort data=sub_venousph nodupkey out=sub_venousph1;
by subject_id; run;
* 48 rows;


** platelets;
data items_platelet;
   set items;
   if index(upcase(label),upcase("platelet"))>0;
run;
proc freq data = chartevents (where = (itemid IN (
828, 3789, 6256, 30006, 30105, 225170, 227071, 227457, 225678, 226369
)));
table itemid;
run;
* have obs: 828, 227457;
* no obs: 3789, 6256, 30006, 30105, 225170, 227071, 225678, 226369;
data sub_platelet (where=(itemid IN (828, 227457)));
set chartevents; run;
proc sort data=sub_platelet;
by subject_id icustay_id charttime; run;
proc sort data=sub_platelet nodupkey out=sub_platelet1;
by subject_id; run;
* 331 rows;


** urine output - no valid variable;
data items_urineoutput;
   set items;
   if index(upcase(label),upcase("urine output"))>0;
run;
proc freq data = chartevents (where = (itemid IN (42676, 42068, 42119, 43966, 43348,
 43365, 43372, 44706, 44911, 44325, 45304, 46578, 46658, 44824, 45804, 43638, 42366, 45991, 227519
)));
table itemid;
run;
* have obs: 227519;
* no obs: 42676, 42068, 42119, 43966, 43348, 43365, 43372, 44706, 44911, 44325, 45304, 46578, 46658,
 44824, 45804, 43638, 42366, 45991;
data sub_urineoutput (where=(itemid IN (227519)));
set chartevents; run;
proc sort data=sub_urineoutput;
by subject_id icustay_id charttime; run;
proc sort data=sub_urineoutput nodupkey out=sub_urineoutput1;
by subject_id; run;
* 1 row;


proc freq data = labevents (where = (itemid IN (51006)));
table itemid;
run;
* frequency: 6330;
data sub_51006 (where=(itemid IN (51006)));
set labevents; run;
proc sort data=sub_51006;
by subject_id ; run;
proc sort data=sub_51006 nodupkey out=sub_51006a;
by subject_id; run;
* 1 row;
proc univariate data=sub_51006;
run;
 
 
** blood culture - no variable;
data items_bloodculture;
   set items;
   if index(upcase(label),upcase("blood culture"))>0;
run;

proc freq data = chartevents (where = (itemid IN (938, 942, 3333, 225401, 70011, 70012, 70013, 70014, 70016, 70060
)));
table itemid;
run;
* no obs: 938, 942, 3333, 225401, 70011, 70012, 70013, 70014, 70016, 70060;


** urine culture - no variable;
data items_urineculture;
   set items;
   if index(upcase(label),upcase("urine culture"))>0;
run;
proc freq data = chartevents (where = (itemid IN (941, 4855, 225454)));
table itemid;
run;
* no obs: 941, 4855, 225454;


** cvp;
data items_cvp;
   set items;
   if index(upcase(label),upcase("central venous pressure"))>0;
run;
* have obs: 220072, 220073, 220074;
data items_cvp2;
   set items;
   if index(upcase(label),upcase("cvp"))>0;
run;
proc freq data = chartevents (where = (itemid IN (1103, 113, 3345, 5814, 8511, 8548, 220074)));
table itemid;
run;
* have obs: 113, 5814, 8548;
* no obs: 1103, 3345, 8511;

data item220074 (where=(itemid=220074));
set chartevents;
run;
proc sort data=item220074 nodupkey;
by subject_id;
run;
proc univariate data=item220074;
run;

data sub_cvp (where=(itemid IN (113, 220074)));
set chartevents; run;
proc sort data=sub_cvp;
by subject_id icustay_id charttime; run;
proc sort data=sub_cvp nodupkey out=sub_cvp1;
by subject_id; run;
* 109 rows;

proc sort data=sub_cvp;
by subject_id storetime;
run;

data item113 (where=(itemid=113));
set chartevents; run;

proc sort data=item113;
by subject_id itemid; run;
proc sort data=item113 NODUPKEY out=item113nd;
by subject_id; run;

proc univariate data=item113; run;

data item5814 (where=(itemid=5814));
set chartevents; run;
* 3907 obs;
proc sort data=item5814;
by subject_id itemid; run;
proc sort data=item5814 NODUPKEY out=item5814nd;
by subject_id; run;
* 41 unique;
proc univariate data=item5814; run;
* 0 - 4 mmHg;

data item8548 (where=(itemid=8548));
set chartevents; run;
* 3879 obs;
proc sort data=item8548;
by subject_id itemid; run;
proc sort data=item8548 NODUPKEY out=item8548nd;
by subject_id; run;
* 35 unique;
proc univariate data=item8548; run;
* 16 to 30 mmHg;


** respiratory rate;
data items_respiratoryrate;
   set items;
   if index(upcase(label),upcase("respiratory rate"))>0;
run;
proc freq data = chartevents (where = (itemid IN (
618, 619, 224688, 224689, 224690, 220210)));
table itemid;
run;
* have obs: 618, 619, 224688, 224689, 224690, 220210;
data sub_rr (where=(itemid IN (618, 619, 224688, 224689, 224690, 220210)));
set chartevents; run;
proc sort data=sub_rr;
by subject_id icustay_id charttime; run;
proc sort data=sub_rr nodupkey out=sub_rr1;
by subject_id; run;
* 333 rows;

data sub_rr (where=(itemid IN (618, 220210)));
set chartevents; run;
proc sort data=sub_rr;
by subject_id icustay_id charttime; run;
proc sort data=sub_rr nodupkey out=sub_rr1;
by subject_id; run;
* 333 rows;


data item618 (where=(itemid=618));
set chartevents; run;

proc sort data=item618;
by subject_id itemid; run;
proc sort data=item618 NODUPKEY out=item618nd;
by subject_id; run;

proc univariate data=item618; run;

data item619 (where=(itemid=619));
set chartevents; run;

proc sort data=item619;
by subject_id itemid; run;
proc sort data=item619 NODUPKEY out=item619nd;
by subject_id; run;

proc univariate data=item619; run;

data item224688 (where=(itemid=224688));
set chartevents; run;
proc sort data=item224688;
by subject_id itemid; run;
proc sort data=item224688 NODUPKEY out=item224688nd;
by subject_id; run;
proc univariate data=item224688; run;

data item224689 (where=(itemid=224689));
set chartevents; run;
proc sort data=item224689;
by subject_id itemid; run;
proc sort data=item224689 NODUPKEY out=item224689nd;
by subject_id; run;
proc univariate data=item224689; run;

data item224690 (where=(itemid=224690));
set chartevents; run;
proc sort data=item224690;
by subject_id itemid; run;
proc sort data=item224690 NODUPKEY out=item224690nd;
by subject_id; run;
proc univariate data=item224690; run;

data item220210 (where=(itemid=220210));
set chartevents; run;
proc sort data=item220210;
by subject_id itemid; run;
proc sort data=item220210 NODUPKEY out=item220210nd;
by subject_id; run;
proc univariate data=item220210; run;



** tidal vol;
data items_tidalvol;
   set items;
   if index(upcase(label),upcase("tidal vol"))>0;
run;
proc freq data = chartevents (where = (itemid IN (5593, 639, 654, 681, 682, 683, 684, 3082, 
3083, 1514, 1570, 1618, 1651, 1660, 2043, 2044, 2049, 2065, 2069, 2400, 2402, 2408, 2420, 2534, 
2990, 3003, 3050, 224684, 224685, 224686
)));
* 639, 654, 681, 682, 683, 684,224685,224684,224686 from reference site;
table itemid;
run;
* have obs: 682, 683, 684, 224684, 224685, 224686;
* no obs: 5593, 639, 654, 681, 3082, 3083, 1514, 1570, 1618, 1651, 1660, 2043, 2044, 2049, 
2065, 2069, 2400, 2402, 2408, 2420, 2534, 2990, 3003, 3050;
data sub_tidalvol (where=(itemid IN (682, 683, 684, 224684, 224685, 224686)));
set chartevents; run;
proc sort data=sub_tidalvol;
by subject_id icustay_id charttime; run;
proc sort data=sub_tidalvol nodupkey out=sub_tidalvol1;
by subject_id; run;
* 109 rows;

data sub_tidalvol (where=(itemid IN (682,224685)));
set chartevents; run;
proc sort data=sub_tidalvol;
by subject_id icustay_id charttime; run;
proc sort data=sub_tidalvol nodupkey out=sub_tidalvol1;
by subject_id; run;
* 109 rows;


data item682 (where=(itemid=682));
set chartevents; run;
proc sort data=item682;
by subject_id itemid; run;
proc sort data=item682 NODUPKEY out=item682nd;
by subject_id; run;
proc univariate data=item682; run;

data item683 (where=(itemid=683));
set chartevents; run;
proc sort data=item683;
by subject_id itemid; run;
proc sort data=item683 NODUPKEY out=item683nd;
by subject_id; run;
proc univariate data=item683; run;



** vital capacity - no variable;
data items_vc;
   set items;
   if index(upcase(label),upcase("vital capacity"))>0;
run;
proc freq data = chartevents (where = (itemid IN (220218
)));
table itemid;
run;

data items_vc;
   set items;
   if index(upcase(label),upcase("vc"))>0;
run;
proc freq data = chartevents (where = (itemid IN (1325
)));
table itemid;
run;
* no obs: 220218, 1325;


** negative inspiratory force ;
proc freq data = chartevents (where = (itemid IN (224419, 459
)));
table itemid;
run;
* no obs: 224419;
* have obs: 459;
data sub_nif (where=(itemid IN (459)));
set chartevents; run;
proc sort data=sub_nif;
by subject_id icustay_id charttime; run;
proc sort data=sub_nif nodupkey out=sub_nif1;
by subject_id; run;
* 19 rows;


** minute ventilation;
* munute volume - 11/12/18;
proc freq data = chartevents (where = (itemid IN (445, 448, 449, 450, 1340, 1486, 1600, 224687)));
table itemid;
run;
data minven (where = (itemid IN (450, 224687)));
set chartevents;
run;
proc sort data=minven;
by subject_id;
run;
proc sort data=minven nodupkey out=minven1;
by subject_id;
run;
*itemid frequency
449		13	
450		2158
1486	16
224687	2364;

data sub_450 (where=(itemid IN (450)));
set chartevents; run;
proc sort data=sub_450;
by subject_id; run;
proc sort data=sub_450 nodupkey out=sub_450a;
by subject_id; run;
proc univariate data=sub_450; run;


data sub_224687 (where=(itemid IN (224687)));
set chartevents; run;
proc sort data=sub_224687;
by subject_id; run;
proc sort data=sub_224687 nodupkey out=sub_224687a;
by subject_id; run;
proc univariate data=sub_224687; run;

* have obs: 778;
data sub_paco2 (where=(itemid IN (778)));
set chartevents; run;
proc sort data=sub_paco2;
by subject_id icustay_id charttime; run;
proc sort data=sub_paco2 nodupkey out=sub_paco21;
by subject_id; run;
* 107 rows;


** FiO2;
data items_fio2;
   set items;
   if index(upcase(label),upcase("fio2"))>0;
run;
proc freq data = chartevents (where = (itemid IN (1040, 1206, 185, 186, 189, 190, 191, 
727, 3420, 3421, 3422, 1863, 5955, 2518, 2981, 7018, 7041, 7570, 8517, 227009, 227010, 226754, 223835)));
table itemid;
run;
* have obs: 185, 186, 189, 190, 227010;
* no obs: 1040, 1206, 191, 727, 3420, 3421, 3422, 1863, 5955, 2518, 2981, 7018, 7041, 7570, 8517, 227009, 226754;


data sub_fio2 (where=(itemid IN (190)));
set chartevents; run;
proc sort data=sub_fio2;
by subject_id; run;
proc sort data=sub_fio2 nodupkey out=sub_fio2a;
by subject_id; run;

data sub_fio2 (where=(itemid IN (223835)));
set chartevents; run;
proc sort data=sub_fio2;
by subject_id; run;
proc sort data=sub_fio2 nodupkey out=sub_fio2a;
by subject_id; run;
proc univariate data=sub_fio2;
run;

proc freq data = labevents (where = (itemid IN (50816)));
table itemid;
run;
* frequency:660;
data sub_fio2 (where=(itemid IN (50816)));
set labevents; run;
proc sort data=sub_fio2;
by subject_id; run;
proc sort data=sub_fio2 nodupkey out=sub_fio2a;
by subject_id; run;
proc univariate data=sub_fio2;
run;

* Dr. Mendel suggested 190;

data sub_fio2 (where=(itemid IN (190)));
set chartevents; run;
proc sort data=sub_fio2;
by subject_id icustay_id charttime; run;
proc sort data=sub_fio2 nodupkey out=sub_fio21;
by subject_id; run;
* 75 rows;
proc univariate data=sub_fio2;
run;



** PAO2;
proc freq data = chartevents (where = (itemid IN (490)));
table itemid;
run;
* have obs: 490;
data sub_pao2 (where=(itemid IN (490)));
set chartevents; run;
proc sort data=sub_pao2;
by subject_id icustay_id charttime; run;
proc sort data=sub_pao2 nodupkey out=sub_pao21;
by subject_id; run;
* 6 rows;


** Arterial PaO2;
proc freq data = chartevents (where = (itemid IN (779)));
table itemid;
run;
* have obs: 779;
data sub_arterialpao2 (where=(itemid IN (779)));
set chartevents; run;
proc sort data=sub_pao2;
by subject_id icustay_id charttime; run;
proc sort data=sub_arterialpao2 nodupkey out=sub_arterialpao21;
by subject_id; run;
* 107 rows;

