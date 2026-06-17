param([string]$Q="",[string]$C="",[switch]$L,[switch]$H)
$kb=Get-Content (Join-Path (Split-Path $MyInvocation.MyCommand.Path) "..\references\knowledge-base.json") -Raw|ConvertFrom-Json
if($H){Write-Host "用法: -Q 概念 | -C 章节 | -L 列表 | -H 帮助";return}
if($L){$kb|%{$_.concepts}|%{$_}|Sort-Object -Unique;return}
if($Q){$kb|Where-Object{$_.text-like"*$Q*"-or$_.concepts-contains$Q}|%{Write-Host "$($_.id): $($_.heading)"}}
if($C){$kb|Where-Object{$_.chapter-like"*$C*"}|%{Write-Host "$($_.id): $($_.heading)"}}
