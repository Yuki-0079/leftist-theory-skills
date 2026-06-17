param([string]$Q="",[switch]$Help)
if($Help){Write-Host 'Query: .\query_kb.ps1 -Q ""'; exit}
$kb=Get-Content "$PSScriptRoot\..\references\knowledge-base.json" -Raw -Encoding UTF8|ConvertFrom-Json
if($Q){$kb|Where-Object{$_.text-like"*$Q*"-or($_.concepts-join' ')-like"*$Q*"}|ForEach-Object{Write-Host "[$($_.id)] $($_.concepts -join ',')"}}
else{Write-Host "Enjoy Your Symptom KB - $($kb.Count) entries"}
