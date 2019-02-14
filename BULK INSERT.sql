BULK INSERT [Warehouse].[ICUSTAYS]
FROM 'C:\Users\Alex\Documents\Engineering Project\Tables\ICUSTAYS.csv'
WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '\n', TABLOCK)
GO

SELECT * FROM Warehouse.ICUSTAYS;



BULK INSERT [Warehouse].[PATIENTS]
FROM 'C:\Users\Alex\Documents\Engineering Project\Tables\PATIENTS.csv'
WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '0x0a', TABLOCK)
GO

SELECT * FROM Warehouse.PATIENTS;



BULK INSERT [Warehouse].[DATETIMEEVENTS]
FROM 'C:\Users\Alex\Documents\Engineering Project\Tables\DATETIMEEVENTS.csv'
WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '0x0a', TABLOCK)
GO

SELECT * FROM Warehouse.DATETIMEEVENTS;