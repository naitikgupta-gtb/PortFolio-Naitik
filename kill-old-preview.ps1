#requires -Version 5.1
$ErrorActionPreference = 'SilentlyContinue'

# Kill any running vite preview/dev servers I may have started earlier
Get-CimInstance Win32_Process -Filter "Name = 'cmd.exe'" |
    Where-Object { $_.CommandLine -like '*vite*5180*' -or $_.CommandLine -like '*vite*preview*' } |
    ForEach-Object {
        Write-Host "Killing PID $($_.ProcessId): $($_.CommandLine)" -ForegroundColor Yellow
        Stop-Process -Id $_.ProcessId -Force -EA SilentlyContinue
    }

# Kill any node processes running vite
Get-CimInstance Win32_Process -Filter "Name = 'node.exe'" |
    Where-Object { $_.CommandLine -like '*vite*' -and $_.CommandLine -notlike '*deplox*' } |
    ForEach-Object {
        Write-Host "Killing vite node PID $($_.ProcessId)" -ForegroundColor Yellow
        Stop-Process -Id $_.ProcessId -Force -EA SilentlyContinue
    }

Start-Sleep -Seconds 1

# Verify 5180 is free
$port5180 = Get-NetTCPConnection -LocalPort 5180 -EA SilentlyContinue
if ($port5180) {
    Write-Host "5180 still occupied by PID $($port5180.OwningProcess)" -ForegroundColor Red
} else {
    Write-Host "5180 free" -ForegroundColor Green
}
$port5181 = Get-NetTCPConnection -LocalPort 5181 -EA SilentlyContinue
if ($port5181) {
    Write-Host "5181 occupied by PID $($port5181.OwningProcess)" -ForegroundColor Yellow
} else {
    Write-Host "5181 free" -ForegroundColor Green
}