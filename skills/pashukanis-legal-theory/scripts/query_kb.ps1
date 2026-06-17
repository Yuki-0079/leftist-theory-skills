param([string]$Query="",[string]$Chapter="",[switch]$ListConcepts,[switch]$Help)
$scriptDir=Split-Path -Parent $MyInvocation.MyCommand.Path
$kbPath=Join-Path $scriptDir "..\references\knowledge-base.json"
$conceptMap=@{
    "商品形式"=@{aliases=@("commodity form");related=@("法律形式","主体");difficulty="★★★";entries=@("ps-001","ps-003")}
    "法律形式"=@{aliases=@("legal form","法权形式");related=@("商品形式","法律主体");difficulty="★★★";entries=@("ps-001","ps-005")}
    "法律主体"=@{aliases=@("legal subject","主体");related=@("法律关系","交换");difficulty="★★☆";entries=@("ps-002","ps-003")}
    "法律拜物教"=@{aliases=@("legal fetishism");related=@("商品拜物教","意识形态");difficulty="★★★";entries=@("ps-004")}
    "法的消亡"=@{aliases=@("withering away of law");related=@("商品形式","共产主义");difficulty="★★★";entries=@("ps-009")}
    "公法与私法"=@{aliases=@();related=@("法权形式");difficulty="★★☆";entries=@("ps-005")}
    "法与国家"=@{aliases=@();related=@("国家","强制");difficulty="★★☆";entries=@("ps-006")}
    "等价交换"=@{aliases=@();related=@("惩罚","违法");difficulty="★★☆";entries=@("ps-008")}
}
if($Help){Write-Host "...用法...";exit}
if(-not(Test-Path $kbPath)){Write-Error "KB not found";exit 1}
$kb=Get-Content $kbPath -Raw|ConvertFrom-Json
if($ListConcepts){$conceptMap.Keys|Sort-Object|ForEach-Object{Write-Host "[$($conceptMap[$_].difficulty)] $_"};exit}
if($Chapter){$kb|Where-Object{$_.chapter-like"*$Chapter*"}|ForEach-Object{Write-Host "[$($_.id)] $($_.chapter) - $($_.concepts -join ', ')"};exit}
if($Query){$r=$kb|Where-Object{$_.text-like"*$Query*"-or($_.concepts|Where-Object{$_-like"*$Query*"})};$r|ForEach-Object{Write-Host "[$($_.id)] $(if($_.text.Length-gt200){$_.text.Substring(0,200)}else{$_.text})"};exit}
Write-Host "用法: -Query / -Chapter / -ListConcepts"
