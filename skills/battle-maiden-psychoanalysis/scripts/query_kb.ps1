param([string]$Query="",[string]$Chapter="",[switch]$ListConcepts,[switch]$Help)
$scriptDir=Split-Path -Parent $MyInvocation.MyCommand.Path
$kbPath=Join-Path $scriptDir "..\references\knowledge-base.json"
$conceptMap=@{
    "战斗美少女"=@{difficulty="★★☆";entries=@("bm-001","bm-003","bm-004","bm-006","bm-007")}
    "菲勒斯少女"=@{difficulty="★★★";entries=@("bm-005","bm-010")}
    "御宅"=@{difficulty="★★☆";entries=@("bm-001","bm-002","bm-009")}
    "虚構的对象"=@{difficulty="★★★";entries=@("bm-009")}
    "亨利·达格"=@{difficulty="★★☆";entries=@("bm-006")}
}
if($Help){Write-Host "用法...";exit}
if(-not(Test-Path $kbPath)){exit 1}
$kb=Get-Content $kbPath -Raw|ConvertFrom-Json
if($ListConcepts){$conceptMap.Keys|Sort-Object|ForEach-Object{Write-Host "[$($conceptMap[$_].difficulty)] $_"};exit}
if($Chapter){$kb|Where-Object{$_.chapter-like"*$Chapter*"}|ForEach-Object{Write-Host "[$($_.id)] $($_.chapter)"};exit}
if($Query){$r=$kb|Where-Object{$_.text-like"*$Query*"};$r|ForEach-Object{Write-Host "[$($_.id)] $(if($_.text.Length-gt200){$_.text.Substring(0,200)}else{$_.text})"};exit}
Write-Host "\n战斗美少女的精神分析 - KB查询\n用法: .\query_kb.ps1 -Query "概念""
