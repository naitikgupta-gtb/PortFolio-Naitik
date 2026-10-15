#requires -Version 5.1
$ErrorActionPreference = 'Stop'
Set-Location 'C:\Users\naiti\Desktop\portfolio-Template'
Write-Host "[build] Running npm run build..." -ForegroundColor Cyan
npm run build 2>&1 | Tee-Object -FilePath "$PSScriptRoot\build-output.log" | Select-Object -Last 30