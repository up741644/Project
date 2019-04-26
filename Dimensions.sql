--Date Dimension (Needs PK's - Possible Auto Increment)

CREATE TABLE Dim.[Date] (
	Date_ID INT IDENTITY(1,1) PRIMARY KEY,
	ADMITTIME DATETIME2,
	DISCHTIME DATETIME2,
	DEATHTIME DATETIME2,
	INTIME VARCHAR(20),
	OUTIME VARCHAR(20),
	EDREGTIME DATETIME2,
	EDOUTTIME DATETIME2,
	CHARTTIME DATETIME2,
	STORETIME DATETIME2,
);

INSERT INTO Dim.[Date] (INTIME, OUTIME)
SELECT INTIME, OUTTIME
FROM Stage.ICUSTAYS;

INSERT INTO Dim.[Date] (DISCHTIME, DEATHTIME, EDREGTIME, EDOUTTIME)
SELECT DISCHTIME, DEATHTIME, EDREGTIME, EDOUTTIME
FROM Stage.ADMISSIONS;

INSERT INTO Dim.[Date] (CHARTTIME, STORETIME)
SELECT CHARTTIME, STORETIME
FROM Stage.CHARTEVENTS; -- Need to do

-- Patient Dimension

CREATE TABLE Dim.Patient (
	Patient_ID INT IDENTITY(1,1) PRIMARY KEY,
	Gender VARCHAR(5),
	DOB DATETIME2,
	DOD DATETIME2,
	Ethnicity VARCHAR(200)
);

INSERT INTO Dim.Patient (Gender, DOB, DOD)
SELECT GENDER, DOB, DOD
FROM Stage.PATIENTS;

INSERT INTO Dim.Patient (Ethnicity)
SELECT ETHNICITY
FROM Stage.ADMISSIONS;

-- Hospital Dimension

CREATE TABLE Dim.Hospital (
	Hospital_ID INT IDENTITY(1,1) PRIMARY KEY,
	EventType VARCHAR(20),
	AdmissionType VARCHAR(50),
	AdmissionLocation VARCHAR(50),
	DischargeLocation VARCHAR(50),
	LengthOfStay DOUBLE PRECISION
);

INSERT INTO Dim.Hospital (EventType)
SELECT EVENTTYPE
FROM Stage.TRANSFERS;

INSERT INTO Dim.Hospital (AdmissionType, AdmissionLocation, DischargeLocation)
SELECT ADMISSION_TYPE, ADMISSION_LOCATION, DISCHARGE_LOCATION
FROM Stage.ADMISSIONS;

INSERT INTO Dim.Hospital (LengthOfStay)
SELECT LOS
FROM Stage.ICUSTAYS;

-- Diagnosis Dimension

CREATE TABLE Dim.Diagnosis (
	Diagnosis_ID INT IDENTITY(1,1) PRIMARY KEY,
	Diagnosis VARCHAR(255),
	Category VARCHAR(100),
	Label VARCHAR(200)
);

INSERT INTO Dim.Diagnosis (Diagnosis)
SELECT DIAGNOSIS
FROM Stage.ADMISSIONS

INSERT INTO Dim.Diagnosis (Category, Label)
SELECT CATEGORY, LABEL
FROM Stage.D_ITEMS


--Length of Stay Fact

CREATE TABLE Fact.LengthOfStay (
	Date_ID INT REFERENCES Dim.[Date](Date_ID),
	Patient_ID INT REFERENCES Dim.Patient(Patient_ID),
	Hospital_ID INT REFERENCES Dim.Hospital(Hospital_ID),
	Diagnosis_ID INT REFERENCES Dim.Diagnosis(Diagnosis_ID),
	Hours INT,
	Days INT,
	Weeks INT
);

INSERT INTO Fact.LengthOfStay (Date_ID)
SELECT Date_ID
FROM Dim.[Date]

INSERT INTO Fact.LengthOfStay (Patient_ID)
SELECT Patient_ID
FROM Dim.Patient

INSERT INTO Fact.LengthOfStay (Hospital_ID)
SELECT Hospital_ID
FROM Dim.Hospital

INSERT INTO Fact.LengthOfStay (Diagnosis_ID)
SELECT Diagnosis_ID
FROM Dim.Diagnosis