param($Query, $Chapter, [switch]$ListConcepts)
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$kb = Get-Content "$scriptDir\..\references\knowledge-base.json" -Raw | ConvertFrom-Json
if ($ListConcepts) { $kb | ForEach-Object { $_.concepts } | Select-Object -Unique | Sort-Object; exit }
if ($Chapter) { $kb | Where-Object { $_.chapter -like "*$Chapter*" } | ForEach-Object { Write-Host "[$($_.id)] $($_.chapter) - $($_.concepts -join ', ')" }; exit }
if ($Query) { $kb | Where-Object { $_.text -like "*$Query*" } | ForEach-Object { Write-Host "[$($_.id)] $($_.text.Substring(0, [Math]::Min(200, $_.text.Length)))" }; exit }
Write-Host "用法: -Query词 / -Chapter章 / -ListConcepts"
