#requires -Version 5.1
$ErrorActionPreference = 'Stop'
$json = Get-Content 'C:\Users\naiti\Desktop\portfolio-Template\public\portfolio.json' -Raw | ConvertFrom-Json

Write-Host "[verify] portfolio.json OK" -ForegroundColor Green
Write-Host "  name: $($json.name)"
Write-Host "  role: $($json.role)"
Write-Host "  tagline: $($json.tagline)"
Write-Host "  github: $($json.socials.github)"
Write-Host "  skills: $($json.skills.Count) categories"
Write-Host "  projects: $($json.projects.Count) projects"
Write-Host ""
Write-Host "[verify] Project titles:" -ForegroundColor Cyan
foreach ($p in $json.projects) {
    Write-Host "  $($p.id). $($p.title)"
}
Write-Host ""
Write-Host "[verify] Skill categories:" -ForegroundColor Cyan
foreach ($s in $json.skills) {
    Write-Host "  $($s.category): $($s.items -join ', ')"
}
Write-Host ""
Write-Host "[verify] TBD placeholders to fill in morning:" -ForegroundColor Yellow
Write-Host "  email: $($json.email)"
Write-Host "  linkedin: $($json.socials.linkedin)"
Write-Host "  education.degree: $($json.education[0].degree)"
Write-Host "  education.year: $($json.education[0].year)"