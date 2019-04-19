BULK INSERT [Stage].[ICUSTAYS]
FROM 'C:\Users\Alex\Documents\EngineeringProject\Tables\ICUSTAYS.csv'
WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '\n', TABLOCK)
GO

SELECT * FROM Stage.ICUSTAYS;



BULK INSERT [Stage].[PATIENTS]
FROM 'C:\Users\Alex\Documents\EngineeringProject\Tables\PATIENTS.csv'
WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '0x0a', TABLOCK)
GO

SELECT * FROM Stage.PATIENTS;



BULK INSERT [Stage].[DATETIMEEVENTS]
FROM 'C:\Users\Alex\Documents\EngineeringProject\Tables\DATETIMEEVENTS.csv'
WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '0x0a', TABLOCK)
GO

SELECT * FROM Stage.DATETIMEEVENTS;



BULK INSERT [Stage].[CHARTEVENTS]
FROM 'C:\Users\Alex\Documents\EngineeringProject\Tables\CHARTEVENTSTest.csv' -- Needs data
WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '0x0a', TABLOCK)
GO

SELECT * FROM Stage.CHARTEVENTS;



BULK INSERT [Stage].[TRANSFERS]
FROM 'C:\Users\Alex\Documents\EngineeringProject\Tables\TRANSFERS.csv'
WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '0x0a', TABLOCK)
GO

SELECT * FROM Stage.TRANSFERS;



BULK INSERT [Stage].[OUTPUTEVENTS]
FROM 'C:\Users\Alex\Documents\EngineeringProject\Tables\OUTPUTEVENTS.csv' -- Needs data
WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '\n', TABLOCK)
GO

SELECT * FROM Stage.OUTPUTEVENTS;



BULK INSERT [Stage].[ADMISSIONS]
FROM 'C:\Users\Alex\Documents\EngineeringProject\Tables\ADMISSIONS.csv'
WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '0x0a', TABLOCK)
GO

SELECT * FROM Stage.ADMISSIONS;


BULK INSERT [Stage].[D_ITEMS]
FROM 'C:\Users\Alex\Documents\EngineeringProject\Tables\D_ITEMS.csv'
WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '0x0a', TABLOCK)
GO

SELECT * FROM Stage.D_ITEMS;