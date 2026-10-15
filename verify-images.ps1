#requires -Version 5.1
$ErrorActionPreference = 'SilentlyContinue'

Write-Host "[verify] Image files in public/:" -ForegroundColor Cyan
Get-ChildItem 'C:\Users\naiti\Desktop\portfolio-Template\public' -File |
    Where-Object { $_.Extension -in '.png', '.jpg', '.jpeg' } |
    Select-Object Name |
    Format-Table -AutoSize | Out-String | Write-Host

Write-Host "[verify] Mismatch check:" -ForegroundColor Cyan
$json = Get-Content 'C:\Users\naiti\Desktop\portfolio-Template\public\portfolio.json' -Raw | ConvertFrom-Json
$files = Get-ChildItem 'C:\Users\naiti\Desktop\portfolio-Template\public' -File |
    Where-Object { $_.Extension -in '.png', '.jpg', '.jpeg' } |
    ForEach-Object { $_.Name }

$json | ForEach-Object { $_ } | Out-Null
foreach ($p in $json.projects) {
    if ($p.image) {
        if ($files -contains $p.image) {
            Write-Host "  [OK] $($p.title): $($p.image)" -ForegroundColor Green
        } else {
            Write-Host "  [MISSING] $($p.title): $($p.image) -- not found!" -ForegroundColor Red
            # Try fuzzy match
            $similar = $files | Where-Object { $_ -like "*$($p.title.Split(' ')[0])*" }
            if ($similar) { Write-Host "    Did you mean: $similar" -ForegroundColor Yellow }
        }
    }
}
$profile = $json.profileImage
if ($files -contains $profile) {
    Write-Host "  [OK] profileImage: $profile" -ForegroundColor Green
} else {
    Write-Host "  [MISSING] profileImage: $profile" -ForegroundColor Red
    $similar = $files | Where-Object { $_ -like "*$($profile.Split('.')[0])*" }
    if ($similar) { Write-Host "    Did you mean: $similar" -ForegroundColor Yellow }
}