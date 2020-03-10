* starting 11/13/18;
* This program is about 2 variables for platelets;
* using 12-hr timepoint instead of 6;
* no analyses using summary measures for this predictor;

LIBNAME kidney '/folders/myfolders';

PROC IMPORT datafile = '/folders/myfolders/chartevents_whole.csv' OUT = work.chartevents 
DBMS = CSV REPLACE;
RUN;

PROC IMPORT datafile = '/folders/myfolders/icustays_whole.csv' OUT = work.icustays
DBMS = CSV REPLACE;
RUN;

PROC IMPORT datafile = '/folders/myfolders/d_items_whole.csv' OUT = work.d_items
DBMS = CSV REPLACE;
RUN;

PROC IMPORT datafile = '/folders/myfolders/admissions_whole.csv' OUT = work.admissions
DBMS = CSV REPLACE;
RUN;

* First, remove those rows without icustay_id (some icustay_id rows = ".") ;
DATA chartevents (WHERE=(icustay_id ne .));
SET chartevents;
run;

data admissions (where=(has_chartevents_data = 1));
set admissions;
run;


* Sort chartevents by hadm_id ;

proc sort data=chartevents out=x1;
by hadm_id;
run;
* Sort admissions by hadm_id ;
proc sort data=admissions out=x2;
by hadm_id;
run;

* Merge chartevents and admissions using subject_id;
data x;
   merge x1(in=a) x2(in=b keep=subject_id hadm_id hospital_expire_flag);
   by hadm_id;
   if a;
run;

proc sort data=x;
by itemid;
run;
proc sort data=d_items out=y;
by itemid;
run;

* Merge chartevents+admissions with d_items ;
* Select only the arterial, systolic blood pressure ;
data z;
merge x(in=a) y(in=b keep=itemid label);
by itemid;
if a and b;
if itemid IN (828 227457);
if value <> 0;
run;

proc freq data=z;
table itemid;
run;

proc sort data=z;
by icustay_id;
run;

proc sort data=z nodupkey out=zz;
by icustay_id;
run;

* 948;

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
* 839 icustay_id;

proc sort data=icu;
by icustay_id;
run;

data timeintck (keep=subject_id itemid icustay_id intime charttime timediff valuenum value hospital_expire_flag);
merge icu(in=a) z(in=b);
by icustay_id;
if a and b;
timediff = intck('minute', intime, charttime);
run;

proc freq data=timeintck;
table itemid;
run;

DATA lessthansix (where= (valuenum ne .));
SET timeintck;
BY icustay_id;
ARRAY t{*} timediff;
IF timediff < 720
THEN OUTPUT;
RUN;

proc sort data=lessthansix nodupkey out=lessthan6;
by icustay_id;
run;
* 287 subjects;

* over 6 hours;
DATA oversix(where = (valuenum ne .));
SET timeintck;
BY icustay_id;
ARRAY t{*} timediff;
IF timediff >= 720
THEN OUTPUT;
RUN;

proc transpose data=lessthansix (keep=icustay_id valuenum)
out=timeintck_w
name=platelets
prefix=pt;
by icustay_id;
run;

* 718;

* Let us look at the observations before 6 hours (720 minutes);
DATA before6;
SET lessthansix;
ARRAY t{*} timediff;
DO i=1 to dim(t) WHILE (timediff le 720);
OUTPUT;
END;
RUN;

DATA before6;
SET before6;
BY icustay_id;
current = LAST.icustay_id;
first = FIRST.icustay_id;
RUN;

DATA before6test (keep=icustay_id firstval first pt_currentval current);
SET before6;
IF first = 1 THEN DO firstval = valuenum;
END;
IF current=1 THEN DO pt_currentval = valuenum;
END;
RUN;

DATA firstvals(keep=icustay_id firstval first);
SET before6test;
run;
DATA firstval(WHERE=(first ne 0));
SET firstvals;
RUN;

DATA currentvals(keep=icustay_id pt_currentval current);
SET before6test;
run;
DATA currentval(WHERE=(current ne 0));
SET currentvals;
run;

data kidney.pt_allcv (drop=current);
set currentval;
run;
* 718;



* ignore below;

* Look at the overall changes between the current value and first value;
DATA changes;
merge firstval currentval;
by icustay_id;
change = pt_currentval - firstval;
IF change > 0 THEN overall="+";
IF change < 0 THEN overall="-";
IF change = 0 THEN overall=0;
run;

proc transpose data=before6 (keep=icustay_id valuenum)
out=kidney.pt_all
name=platelets
prefix=pt;
by icustay_id;
run;

* excluding those with less than 3 observations;
data numbering_pt ;
set platelets;
array pt (*) pt1-pt11 ;
    do i=11 to 1 by -1 until (pt(i) ne .);
    end;
run;

data excludingtoofew_pt;
set numbering_pt;
if i < 3 then three=0;
if i ge 3 then three=1;
run;

* Only 73 out of 718 have at least 3 observations; 

data atleastthree_pt (where=(three=1));
set excludingtoofew_pt;
run;
* Many subjects have only 1-2 measurements;

* process to figure out a way to find min, max, etc per each subject;
* permanently save in lib. kidney;
data pts (keep = icustay_id pt1--pt9 pt_min pt_mean pt_max pt_range pt_std);
set platelets;
   ARRAY pt(*) pt1-pt9;
   pt_mean = MEAN(OF pt(*));
   pt_min = min(OF pt(*));
   pt_max = max(OF pt(*));
   pt_range = range(OF pt(*));
   pt_std = std(OF pt(*));
   RUN;