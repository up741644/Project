-- Create Table Statesments
-- Staging Tables

CREATE TABLE Stage.CHARTEVENTS 
  ( 
    ROW_ID INT NOT NULL, 
  	SUBJECT_ID INT NOT NULL, 
  	HADM_ID INT, 
  	ICUSTAY_ID INT, 
  	ITEMID INT, 
  	CHARTTIME DATETIME2, 
  	STORETIME DATETIME2, 
  	CGID INT, 
  	[VALUE] VARCHAR(255),
  	VALUENUM DOUBLE PRECISION,
  	VALUEUOM VARCHAR(50), 
  	WARNING INT,
  	ERROR INT,
  	RESULTSTATUS VARCHAR(50),
  	[STOPPED] VARCHAR(50),
  	CONSTRAINT chartevents_rowid_pk PRIMARY KEY (ROW_ID) 
  );


CREATE TABLE Stage.DATETIMEEVENTS 
  ( 
    ROW_ID INT NOT NULL, 
  	SUBJECT_ID INT NOT NULL, 
  	HADM_ID INT, 
  	ICUSTAY_ID INT, 
  	ITEMID INT NOT NULL, 
  	CHARTTIME DATETIME2 NOT NULL, 
  	STORETIME DATETIME2 NOT NULL, 
  	CGID INT NOT NULL, 
  	[VALUE] DATETIME2, 
  	VALUEUOM VARCHAR(50) NOT NULL, 
  	WARNING SMALLINT, 
  	ERROR SMALLINT, 
  	RESULTSTATUS VARCHAR(50), 
  	[STOPPED] VARCHAR(50), 
  	CONSTRAINT datetime_rowid_pk PRIMARY KEY (ROW_ID) 
  ); 

  
CREATE TABLE Stage.ICUSTAYS
  ( 
    ROW_ID INT NOT NULL, 
  	SUBJECT_ID INT NOT NULL, 
  	HADM_ID INT NOT NULL, 
  	ICUSTAY_ID INT NOT NULL, 
  	DBSOURCE VARCHAR(20) NOT NULL, 
  	FIRST_CAREUNIT VARCHAR(20) NOT NULL, 
  	LAST_CAREUNIT VARCHAR(20) NOT NULL, 
  	FIRST_WARDID SMALLINT NOT NULL, 
  	LAST_WARDID SMALLINT NOT NULL, 
  	INTIME VARCHAR(20) NOT NULL, 
  	OUTTIME VARCHAR(20),
  	LOS DOUBLE PRECISION, 
  	CONSTRAINT icustay_icustayid_unique UNIQUE (ICUSTAY_ID), 
  	CONSTRAINT icustay_rowid_pk PRIMARY KEY (ROW_ID) 
  );


CREATE TABLE Stage.PATIENTS 
  (
	ROW_ID INT NOT NULL, 
  	SUBJECT_ID INT NOT NULL, 
  	GENDER VARCHAR(5) NOT NULL, 
  	DOB DATETIME2 NOT NULL, 
  	DOD DATETIME2, 
  	DOD_HOSP DATETIME2, 
  	DOD_SSN DATETIME2, 
  	EXPIRE_FLAG INT NOT NULL, 
    CONSTRAINT pat_subid_unique UNIQUE (SUBJECT_ID), 
    CONSTRAINT pat_rowid_pk PRIMARY KEY (ROW_ID) 
  );


CREATE TABLE Stage.TRANSFERS 
  (	
	ROW_ID INT NOT NULL, 
 	SUBJECT_ID INT NOT NULL, 
 	HADM_ID INT NOT NULL, 
 	ICUSTAY_ID INT, 
 	DBSOURCE VARCHAR(20), 
 	EVENTTYPE VARCHAR(20), 
 	PREV_CAREUNIT VARCHAR(20), 
 	CURR_CAREUNIT VARCHAR(20), 
 	PREV_WARDID SMALLINT, 
 	CURR_WARDID SMALLINT, 
 	INTIME DATETIME2, 
 	OUTTIME DATETIME2, 
 	LOS DOUBLE PRECISION, 
 	CONSTRAINT transfers_rowid_pk PRIMARY KEY (ROW_ID) 
  ); 


CREATE TABLE Stage.OUTPUTEVENTS -- Needs creating
  (	
	ROW_ID INT NOT NULL, 
 	SUBJECT_ID INT NOT NULL, 
 	HADM_ID INT, 
 	ICUSTAY_ID INT, 
 	CHARTTIME VARCHAR(20), 
 	ITEMID INT, 
 	[VALUE] DOUBLE PRECISION, 
 	VALUEUOM VARCHAR(30), 
 	STORETIME VARCHAR(20), 
 	CGID INT,
 	[STOPPED] VARCHAR(30), 
 	NEWBOTTLE CHAR(1), 
 	ISERROR INT, 
 	CONSTRAINT outputevents_cv_rowid_pk PRIMARY KEY (ROW_ID) 
  ); 
 
 
CREATE TABLE Stage.ADMISSIONS 
 ( 
   ROW_ID INT NOT NULL, 
   SUBJECT_ID INT NOT NULL, 
   HADM_ID INT NOT NULL, 
   ADMITTIME DATETIME2 NOT NULL, 
   DISCHTIME DATETIME2 NOT NULL, 
   DEATHTIME DATETIME2, 
   ADMISSION_TYPE VARCHAR(50) NOT NULL, 
   ADMISSION_LOCATION VARCHAR(50) NOT NULL, 
   DISCHARGE_LOCATION VARCHAR(50) NOT NULL, 
   INSURANCE VARCHAR(255) NOT NULL, 
   LANGUAGE VARCHAR(10), 
   RELIGION VARCHAR(50), 
   MARITAL_STATUS VARCHAR(50), 
   ETHNICITY VARCHAR(200) NOT NULL, 
   EDREGTIME DATETIME2, 
   EDOUTTIME DATETIME2, 
   DIAGNOSIS VARCHAR(255), 
   HOSPITAL_EXPIRE_FLAG VARCHAR(150) NULL, 
   HAS_CHARTEVENTS_DATA VARCHAR(100) NOT NULL, 
   CONSTRAINT adm_rowid_pk PRIMARY KEY (ROW_ID), 
   CONSTRAINT adm_hadm_unique UNIQUE (HADM_ID) 
 );


CREATE TABLE Stage.D_ITEMS 
 (	
	ROW_ID INT NOT NULL, 
 	ITEMID INT NOT NULL, 
 	LABEL VARCHAR(200), 
 	ABBREVIATION VARCHAR(100), 
 	DBSOURCE VARCHAR(50), 
 	LINKSTO VARCHAR(50), 
 	CATEGORY VARCHAR(100), 
 	UNITNAME VARCHAR(100), 
 	PARAM_TYPE VARCHAR(100), 
 	CONCEPTID VARCHAR(100), -- Has String Properties
 	CONSTRAINT ditems_itemid_unique UNIQUE (ITEMID), 
 	CONSTRAINT ditems_rowid_pk PRIMARY KEY (ROW_ID) 
 );