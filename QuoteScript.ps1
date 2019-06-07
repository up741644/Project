# Set-ExecutionPolicy RemoteSigned

(Get-Content "C:\Users\Alex\Documents\EngineeringProject\Tables\ICUSTAYS.csv") |
  % { ($_ -replace '^"|"$|(?<=\t)"|"(?=\t)', '') -replace '"', '' } |
    
    Set-Content "C:\Users\Alex\Documents\EngineeringProject\Tables\ICUSTAYS.csv"

Write-Host "Transformation Complete" -ForegroundColor Green