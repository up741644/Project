--Date Dimension (Needs PK's - Possible Auto Increment)

CREATE TABLE Dim.[Date] (
	Date_ID INT IDENTITY(1,1) PRIMARY KEY,
	ADMITTIME DATETIME2,
	DISCHTIME DATETIME2,
	DEATHTIME DATETIME2,
	INTIME VARCHAR(20),
	OUTTIME VARCHAR(20),
	EDREGTIME DATETIME2,
	EDOUTTIME DATETIME2,
	CHARTTIME DATETIME2,
	STORETIME DATETIME2,
);

INSERT INTO Dim.Date (INTIME, OUTTIME, ADMITTIME, DISCHTIME, DEATHTIME, EDREGTIME, EDOUTTIME, CHARTTIME, STORETIME)
SELECT i.INTIME, i.OUTTIME, a.ADMITTIME, a.DISCHTIME, a.DEATHTIME, a.EDREGTIME, a.EDOUTTIME, c.CHARTTIME, c.STORETIME
FROM Stage.ICUSTAYS i
JOIN Stage.ADMISSIONS a ON i.ROW_ID = a.ROW_ID
JOIN Stage.CHARTEVENTS c ON i.ROW_ID = c.ROW_ID

SELECT * FROM Dim.Date;

-- Patient Dimension

CREATE TABLE Dim.Patient (
	Patient_ID INT IDENTITY(1,1) PRIMARY KEY,
	Gender VARCHAR(5),
	DOB DATETIME2,
	DOD DATETIME2,
	Ethnicity VARCHAR(200)
);

INSERT INTO Dim.Patient (Gender, DOB, DOD, Ethnicity)
SELECT p.GENDER, p.DOB, p.DOD, a.ETHNICITY
FROM Stage.PATIENTS p
JOIN Stage.ADMISSIONS a ON p.ROW_ID = a.ROW_ID

SELECT * FROM Dim.Patient;

-- Hospital Dimension

CREATE TABLE Dim.Hospital (
	Hospital_ID INT IDENTITY(1,1) PRIMARY KEY,
	EventType VARCHAR(20),
	AdmissionType VARCHAR(50),
	AdmissionLocation VARCHAR(50),
	DischargeLocation VARCHAR(50),
	LengthOfStay DOUBLE PRECISION
);

INSERT INTO Dim.Hospital (EventType, AdmissionType, AdmissionLocation, DischargeLocation, LengthOfStay)
SELECT t.EventType, a.ADMISSION_LOCATION, a.ADMISSION_LOCATION, a.DISCHARGE_LOCATION, i.LOS
FROM Stage.TRANSFERS t
JOIN Stage.ADMISSIONS a ON t.ROW_ID = a.ROW_ID
JOIN Stage.ICUSTAYS i ON t.ROW_ID = i.ROW_ID;

SELECT * FROM Dim.Hospital;

-- Diagnosis Dimension

CREATE TABLE Dim.Diagnosis (
	Diagnosis_ID INT IDENTITY(1,1) PRIMARY KEY,
	Diagnosis VARCHAR(255),
	Category VARCHAR(100),
	Label VARCHAR(200)
);

INSERT INTO Dim.Diagnosis (Diagnosis, Category, Label)
SELECT a.Diagnosis, i.Category, i.Label
FROM Stage.ADMISSIONS a
JOIN Stage.D_ITEMS i ON a.ROW_ID = i.ROW_ID

SELECT * FROM Dim.Diagnosis;

--Length of Stay Fact

CREATE TABLE Fact.LengthOfStay (
	Date_ID INT REFERENCES Dim.[Date](Date_ID),
	Patient_ID INT REFERENCES Dim.Patient(Patient_ID),
	Hospital_ID INT REFERENCES Dim.Hospital(Hospital_ID),
	Diagnosis_ID INT REFERENCES Dim.Diagnosis(Diagnosis_ID),
	Admitted DATETIME2,
	Discharged DATETIME2
);

INSERT INTO Fact.LengthOfStay (Date_ID, Patient_ID, Hospital_ID, Diagnosis_ID, Admitted, Discharged)
SELECT d.Date_ID, p.Patient_ID, h.Hospital_ID, i.Diagnosis_ID, a.ADMITTIME,  a.DISCHTIME
FROM Dim.Date d
JOIN Dim.Patient p ON d.Date_ID = p.Patient_ID
JOIN Dim.Hospital h ON d.Date_ID = h.Hospital_ID
JOIN Dim.Diagnosis i ON d.Date_ID = i.Diagnosis_ID
JOIN Stage.ADMISSIONS a ON d.Date_ID = a.ROW_ID

SELECT * FROM Fact.LengthOfStay;