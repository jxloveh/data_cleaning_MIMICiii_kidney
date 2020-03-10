* 09/25/2018;
* Haeun Grace Park

* Import and sort table icustays in two ways;

*Do this in two ways. One way, sort the ICUSTAYS table by SUBJECT_ID and then by the ICUSTAY_ID, 
and then keep only the first instance for each SUBJECT_ID. This works if the IDs are increasing 
with each stay. But, what if they don’t work that way? Maybe they changed the system for the IDs?;

PROC IMPORT datafile = '/folders/myfolders/icustays_kidney.csv' OUT = work.icustays DBMS = CSV;
RUN;

PROC SORT DATA=work.icustays OUT = work.icu;
BY SUBJECT_ID ICUSTAY_ID;
RUN;

PROC SORT DATA=work.icu OUT = nodupout NODUPKEY;
BY SUBJECT_ID;
RUN;

*NOTE: There were 378 observations read from the data set WORK.ICU.
 NOTE: 39 observations with duplicate key values were deleted.
 NOTE: The data set WORK.NODUPOUT has 339 observations and 12 variables.;

* 2nd way;
* Import table patients;
PROC IMPORT datafile = '/folders/myfolders/patients.csv' OUT = work.patients DBMS = CSV;
RUN;

* Import table admissions;
PROC IMPORT datafile = '/folders/myfolders/admissions_kidney.csv'
OUT = work.admis 
DBMS = CSV
replace;
RUN;

* A longer way that will provide more surety, is the following:
Merge data from the PATIENTS table and the ADMISSIONS table (hospital admissions) linked by the
HADM_ID to get the hospital stay variables. Then merge in the data from the ICUSTAYS table, linked by
the variable (ICUSTAY_ID). Doing this, you can get the day/time admitted to the hospital and ICU. Then
you can sort by SUBJECT_ID and then the admitting day/time to the hospital, and then the admitting
time for the ICU. Keep only the first ICU stay. ;

data pat_notnull;
set patients;
run;

PROC SORT DATA=patients OUT=patients1; 
  BY subject_id; 
RUN; 

PROC SORT DATA=admis OUT=admis1; 
  BY subject_id; 
RUN;  

DATA merged1; 
  MERGE patients1 admis1; 
  BY subject_id; 
RUN; 

* Admissions table has a subset of the subjects in the patients table.

*NOTE: There were 46520 observations read from the data set WORK.PATIENTS1.
 NOTE: There were 352 observations read from the data set WORK.ADMIS1.
 NOTE: The data set WORK.MERGED1 has 46529 observations and 25 variables.;

PROC SORT DATA=merged1 OUT=merged2; 
  BY hadm_id; 
RUN;

PROC SORT DATA=icustays OUT=icustays1; 
  BY hadm_id; 
RUN; 

DATA merged3; 
  MERGE merged2 icustays1; 
  BY hadm_id; 
RUN; 

*NOTE: There were 46529 observations read from the data set WORK.MERGED2.
 NOTE: There were 378 observations read from the data set WORK.ICUSTAYS1.
 NOTE: The data set WORK.MERGED3 has 46559 observations and 34 variables.;

PROC SORT DATA=work.icustays OUT = work.icu;
BY SUBJECT_ID ICUSTAY_ID intime;
RUN;

PROC SORT DATA=work.icu OUT = nodupout NODUPKEY;
BY SUBJECT_ID;
RUN;

* Hospital stay table: Admission date, Discharge Date, discharge destination, in-hospital death.
ICU Stay table: Admission date, discharge date, discharge destination, ICU death.
Chartevents table: ventilator started, dialysis started, intubation started ;

DATA hspt_stay (KEEP = admittime dischtime discharge_location deathtime);
SET merged3;
RUN;

DATA icu_stay (KEEP = admittime dischtime discharge_location 
