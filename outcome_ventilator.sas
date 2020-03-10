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

PROC IMPORT datafile = '/folders/myfolders/admissions_kidney.csv' OUT = work.admissions
DBMS = CSV REPLACE;
RUN;


* First, remove those rows without icustay_id (some icustay_id rows = ".") ;
DATA chartevents (WHERE=(icustay_id ne .));
SET chartevents;
run;
* 1906279 -> 1906147 rows;

* First, sort chartevents by subject_id & charttime, and then sort it nodupkey by subject_id;
PROC SORT data=chartevents;
BY subject_id charttime;
RUN;

* only the 334;

proc sort data=chartevents out=x1;
by hadm_id;
run;

proc sort data=admissions out=x2;
by hadm_id;
run;

data x;
   merge x1(in=a) x2(in=b keep= subject_id hadm_id hospital_expire_flag);
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

proc print data=z;
run;

* icustay table;

data icustays (keep=subject_id hadm_id icustay_id intime);
set icustays;
run;

proc sort data= icustays;
by subject_id;
run;

proc sort data=icustays nodupkey out=icu;
by subject_id;
run; 
* 339 icustay_id;

proc sort data=x2;
by subject_id;
run;
proc sort data=x1;
by subject_id;
run;

* merge icu only with the death mark;
data icustays_hos;
merge icu(in=a) x2(in=b keep=subject_id hospital_expire_flag);
if a and b;
by subject_id;
run;

data icustays_hosp;
merge icustays_hos(in=a) x1(in=b keep=subject_id itemid charttime);
if a and b;
by subject_id;
run;

proc sort data=icustays_hosp;
by icustay_id;
run;

data ventilator(drop=row_id storetime cgid valueuom warning error resultstatus stopped);
merge z(in=a) icustays_hosp(in=b);
if a or b;
by icustay_id;
run;

data ventilator;
set ventilator;
if itemid IN (720 721 722 227565 227566 223848 223849) 
THEN ven_out = 1;
else ven_out = 0;
run;

data ventil (where=(ven_out=1));
set ventilator;
run;
proc sort data=ventil nodupkey out=ventil1 (keep=icustay_id ven_out hospital_expire_flag) ;
by icustay_id ;
run;
* 120;

data ventil2 (keep=icustay_id ventilator_out);
set ventil1 (rename= (ven_out = ventilator_out));
run;

data ventilator1;
merge ventilator(in=a) ventil2(in=b);
if a and b;
by icustay_id;
if ventilator_out ne 1 THEN ventilator_out=0;
run;

proc sort data=ventilator1 nodupkey out=kidney.ventilator ;
by icustay_id;
run;
* 343;
* STUCK;
* You can check the timing of outcome in relation to the admission to icu (variable: timediff).;

data timeintck;
set kidney.ventilator;
timediff = intck('minute', intime, charttime);
run;

DATA lessthantwelve;
SET first1;
BY icustay_id;
ARRAY t{*} timediff;
IF timediff < 720
THEN OUTPUT;
RUN;

proc sort data=lessthantwelve nodupkey out=lessthan12;
by icustay_id; run;
* ventilator < 12 hours: 332 subjects;

data kidney.exclude_ventilator;
merge lessthantwelve(in=a) first1(in=b);
if not a;
by icustay_id;
run;

proc sort data=kidney.exclude_ventilator nodupkey out=kidney.ex_nd_ventilator;
by icustay_id; run;
* After excluding them, only 31 people are qualified ;



* Ventilator values >= 12 hours;
* save permanently in the kidney library;
DATA kidney.overtwelve ;
SET first1;
BY icustay_id;
ARRAY t{*} timediff;
IF timediff >= 720
THEN OUTPUT;
RUN;

* only the current val of ventilator;
proc sort data=kidney.overtwelve nodupkey out=cv_ventilator ;
by icustay_id;
run;
* 117 rows;


