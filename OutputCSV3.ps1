# Set-ExecutionPolicy RemoteSigned

$SourcePath = "C:\Users\Alex\Documents\EngineeringProject\Tables\CHARTEVENTS.csv";

Import-CSV $SourcePath | select-object -first 500000 |

Export-CSV "C:\Users\Alex\Documents\EngineeringProject\Tables\CHARTEVENTSTest.csv" -NoType -NoClobber;

$Read = 0; Get-Content C:\Users\Alex\Documents\EngineeringProject\Tables\CHARTEVENTSTest.csv | select -first 5000

$NewFilePath = "C:\Users\Alex\Documents\EngineeringProject\Tables\CHARTEVENTSTest.csv"

IF (test-path $NewFilePath) {
    Write-Host "Export Successful" -ForegroundColor Green
} 
ELSE {
        Write-Host "Export Unsuccessful or Not Correcly Initialised" -ForegroundColor Red
}

# Install SQL Server Module
Install-Module -Name SqlServer #-AllowClobber

Write-Host "Connecting to Database" -ForegroundColor Green

# Connection Strings
$Server = "(LocalDB)/MSQLLocalDB"
$Database = "MIMIC-III"
$Table = "CHARTEVENTS"
$SqlConnection = New-Object System.Data.SqlClient.SqlConnection
$SqlConnection.ConnectionString = "Server = $Server; Database = $Database; UID=$DOMAIN\USER;PWD=$password;Integrated Security=true;"

#Variables
$File = "C:\Users\Alex\Documents\EngineeringProject\Tables\CHARTEVENTSTest.csv"
$FirstRow = 2
$FieldTerminator = ','
$RowTerminator = '0x0a'

Invoke-Sqlcmd -Query "BULK INSERT Stage.CHARTEVENTS;"
$File + $FirstRow + $FieldTerminator