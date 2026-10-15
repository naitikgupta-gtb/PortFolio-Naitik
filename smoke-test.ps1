#requires -Version 5.1
$ErrorActionPreference = 'SilentlyContinue'

# Start vite dev in background
Write-Host "[smoke] Starting vite dev server..." -ForegroundColor Cyan
$proc = Start-Process -FilePath 'cmd.exe' -ArgumentList '/c','cd /d C:\Users\naiti\Desktop\portfolio-Template && npx vite --port 5180 --host 127.0.0.1' -WindowStyle Hidden -PassThru
Write-Host "[smoke] Started PID $($proc.Id)"

Start-Sleep -Seconds 6

try {
    $resp = Invoke-WebRequest -Uri 'http://127.0.0.1:5180/' -UseBasicParsing -TimeoutSec 5
    Write-Host "[smoke] GET / -> $($resp.StatusCode)" -ForegroundColor Green
    Write-Host "[smoke] HTML head:" -ForegroundColor Cyan
    Write-Host ($resp.Content.Substring(0, [Math]::Min(300, $resp.Content.Length)))
} catch {
    Write-Host "[smoke] GET / failed: $($_.Exception.Message)" -ForegroundColor Red
}

try {
    $resp = Invoke-WebRequest -Uri 'http://127.0.0.1:5180/portfolio.json' -UseBasicParsing -TimeoutSec 5
    Write-Host "[smoke] GET /portfolio.json -> $($resp.StatusCode) (length=$($resp.Content.Length))" -ForegroundColor Green
} catch {
    Write-Host "[smoke] GET /portfolio.json failed: $($_.Exception.Message)" -ForegroundColor Red
}

# Kill vite
Get-CimInstance Win32_Process -Filter "Name = 'cmd.exe'" |
    Where-Object { $_.CommandLine -like '*vite*5180*' } |
    ForEach-Object {
        Write-Host "[smoke] Killing PID $($_.ProcessId)" -ForegroundColor Yellow
        Stop-Process -Id $_.ProcessId -Force
    }

Write-Host "[smoke] Done." -ForegroundColor Cyan