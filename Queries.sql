-- PowerBI Test Queries
SELECT * FROM [Dim].[Date];
SELECT * FROM [Dim].[Diagnosis];
SELECT * FROM [Dim].[Hospital];
SELECT * FROM [Dim].[Patient];

SELECT COUNT(*)
FROM Dim.Patient
WHERE Gender = 'F';

SELECT COUNT(*)
FROM Dim.Patient
WHERE Gender = 'M';

-- Staging Database Test Queries (Adjusted from original PhysioNet requirements)
SELECT p.subject_id, p.dob, a.hadm_id, a.admittime, p.expire_flag
FROM STAGE.ADMISSIONS a
JOIN STAGE.PATIENTS p
ON p.subject_id = a.subject_id;

SELECT p.subject_id, p.dob, a.hadm_id, a.admittime, p.expire_flag,
MIN (a.admittime) OVER (PARTITION BY p.subject_id) AS first_admittime
FROM STAGE.ADMISSIONS a
JOIN STAGE.PATIENTS p
ON p.subject_id = a.subject_id
ORDER BY a.hadm_id, p.subject_id;

-- Fact Table / Warehouse Queries
SELECT (DATEDIFF(SECOND, l.Admitted, l.Discharged) / 86400) AS 'Difference', p.Gender -- Length of Stay for female patients
FROM Fact.LengthOfStay l
JOIN Dim.Patient p ON l.Patient_ID = p.Patient_ID
WHERE p.Gender = 'F'
ORDER BY (DATEDIFF(SECOND, l.Admitted, l.Discharged) / 86400) ASC;

SELECT (DATEDIFF(SECOND, l.Admitted, l.Discharged) / 86400) AS 'Difference', p.Gender -- Length of Stay for male patients
FROM Fact.LengthOfStay l
JOIN Dim.Patient p ON l.Patient_ID = p.Patient_ID
WHERE p.Gender = 'M'
ORDER BY (DATEDIFF(SECOND, l.Admitted, l.Discharged) / 86400) ASC;

SELECT (DATEDIFF(SECOND, l.Admitted, l.Discharged) / 86400) AS 'Difference', p.Gender -- Length of Stay for all patients
FROM Fact.LengthOfStay l
JOIN Dim.Patient p ON l.Patient_ID = p.Patient_ID
ORDER BY (DATEDIFF(SECOND, l.Admitted, l.Discharged) / 86400) ASC;

SELECT (DATEDIFF(SECOND, l.Admitted, l.Discharged) / 86400) AS 'Difference'
FROM Fact.LengthOfStay l
JOIN Dim.Patient p ON l.Patient_ID = p.Patient_ID
WHERE (DATEDIFF(SECOND, l.Admitted, l.Discharged) / 86400) >= 10;

SELECT (DATEDIFF(DAY, l.Admitted, l.Discharged) / 7) AS 'Duration In Days', h.EventType
FROM Fact.LengthOfStay l
JOIN Dim.Hospital h ON l.Hospital_ID = h.Hospital_ID
JOIN Dim.Patient p ON l.Hospital_ID = p.Patient_ID
WHERE (DATEDIFF(DAY, l.Admitted, l.Discharged) / 7) > 14
AND h.EventType = 'Transfer';

SELECT (DATEDIFF(SECOND, l.Admitted, l.Discharged) % 86400 / 3600) AS 'Duration In Hours', p.Ethnicity
FROM Fact.LengthOfStay l
JOIN Dim.Patient p ON l.Patient_ID = p.Patient_ID
WHERE p.Ethnicity = 'White' AND (DATEDIFF(SECOND, l.Admitted, l.Discharged) % 86400 / 3600) <2
GROUP BY l.Admitted, l.Discharged, p.Ethnicity;

SELECT (DATEDIFF(SECOND, l.Admitted, l.Discharged) / 86400) AS 'Time In Days', p.Patient_ID, -- Length of Stay IF Calculation
CASE
	WHEN (DATEDIFF(SECOND, l.Admitted, l.Discharged) / 86400) BETWEEN 15 AND 21
	THEN 'Three Weeks'
	WHEN (DATEDIFF(SECOND, l.Admitted, l.Discharged) / 86400) BETWEEN 8 AND 14
	THEN 'Over a Week'
	WHEN (DATEDIFF(SECOND, l.Admitted, l.Discharged) / 86400) BETWEEN 2 AND 7
	THEN 'A Week or Under'
	WHEN (DATEDIFF(SECOND, l.Admitted, l.Discharged) / 86400) <= 1
	THEN 'A Day or Under'
	ELSE 'Over Three Weeks'
	END AS 'Length Of Stay'
FROM Fact.LengthOfStay l
JOIN Dim.Patient p ON l.Patient_ID = p.Patient_ID;

SELECT p.Patient_ID, h.LengthOfStay
FROM Fact.LengthOfStay l
JOIN Dim.Hospital h ON l.Hospital_ID = h.Hospital_ID
JOIN Dim.Patient p ON l.Hospital_ID = p.Patient_ID
GROUP BY p.Patient_ID, h.LengthOfStay;

SELECT (DATEDIFF(SECOND, l.Admitted, l.Discharged) / 86400) AS 'Stay Over 100 Hours', d.Diagnosis -- Length of Stay for diagnosis' over 100 hours
FROM Fact.LengthOfStay l
JOIN Dim.Diagnosis d ON l.Diagnosis_ID = d.Diagnosis_ID
WHERE (DATEDIFF(SECOND, l.Admitted, l.Discharged) / 86400) > 100;

SELECT AVG(h.LengthOfStay) AS 'Average Length of Stay', h.AdmissionLocation -- Average Length of Stay per Admission Location
FROM Dim.Hospital h
GROUP BY h.LengthOfStay,  h.AdmissionLocation;

SELECT DISTINCT l.Admitted, l.Discharged, SUM(h.LengthOfStay) AS 'Total LOS', d.Category -- Summed LOS for each Category (not all accurate)
FROM Fact.LengthOfStay l
JOIN Dim.Hospital h ON l.Hospital_ID = h.Hospital_ID
JOIN Dim.Diagnosis d ON l.Diagnosis_ID = d.Diagnosis_ID
WHERE d.Category IS NOT NULL
GROUP BY l.Admitted, l.Discharged, d.Category,
ROLLUP (h.LengthOfStay);

SELECT l.Admitted, l.Discharged, p.Patient_ID, h.DischargeLocation
FROM Fact.LengthOfStay l
JOIN Dim.Patient p ON l.Hospital_ID = p.Patient_ID
JOIN Dim.Hospital h ON l.Hospital_ID = h.Hospital_ID
ORDER BY l.Admitted, l.Discharged;

SELECT p.Patient_ID, h.DischargeLocation
FROM Fact.LengthOfStay l
JOIN Dim.Patient p ON l.Hospital_ID = p.Patient_ID
JOIN Dim.Hospital h ON l.Hospital_ID = h.Hospital_ID
WHERE h.DischargeLocation IN ('HOME', 'SHORT TERM HOSPITAL')
ORDER BY p.Patient_ID;