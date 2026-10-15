#requires -Version 5.1
# preview-portfolio.ps1
# Use vite preview (production build) on a free port — avoids EACCES on 5173.

$ErrorActionPreference = 'SilentlyContinue'

Write-Host "[preview] Building..." -ForegroundColor Cyan
Set-Location 'C:\Users\naiti\Desktop\portfolio-Template'
npm run build 2>&1 | Select-Object -Last 5

Write-Host ""
Write-Host "[preview] Starting preview server on port 5180 (127.0.0.1 only)..." -ForegroundColor Cyan
$proc = Start-Process -FilePath 'cmd.exe' -ArgumentList '/c','cd /d C:\Users\naiti\Desktop\portfolio-Template && npx vite preview --port 5180 --host 127.0.0.1 --strictPort' -WindowStyle Hidden -PassThru
Write-Host "[preview] Started PID $($proc.Id)"
Start-Sleep -Seconds 4

try {
    $resp = Invoke-WebRequest -Uri 'http://127.0.0.1:5180/' -UseBasicParsing -TimeoutSec 5
    Write-Host "[preview] GET / -> $($resp.StatusCode)" -ForegroundColor Green
    Write-Host "[preview] URL: http://127.0.0.1:5180/" -ForegroundColor Cyan
} catch {
    Write-Host "[preview] GET failed: $($_.Exception.Message)" -ForegroundColor Red
}

try {
    $resp = Invoke-WebRequest -Uri 'http://127.0.0.1:5180/portfolio.json' -UseBasicParsing -TimeoutSec 5
    Write-Host "[preview] GET /portfolio.json -> $($resp.StatusCode) (length=$($resp.Content.Length))" -ForegroundColor Green
} catch {
    Write-Host "[preview] /portfolio.json failed: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host ""
Write-Host "[preview] Press Ctrl+C in this terminal to stop the server." -ForegroundColor Yellow
Write-Host "[preview] Or run: Get-Process cmd | Where-Object { `$_.MainWindowTitle -eq '' } | Stop-Process" -ForegroundColor Yellow