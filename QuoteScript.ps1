# Set-ExecutionPolicy RemoteSigned

(Get-Content "C:\Users\Alex\Documents\EngineeringProject\Tables\CHARTEVENTSTestQuotes.csv") |
  % { ($_ -replace '^"|"$|(?<=\t)"|"(?=\t)', '') -replace '"', '' } |
    
    Set-Content "C:\Users\Alex\Documents\EngineeringProject\Tables\CHARTEVENTSTestQuotes.csv"
