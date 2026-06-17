param([string]$Query="",[string]$Chapter="",[switch]$ListConcepts,[switch]$Help)
$scriptDir=Split-Path -Parent $MyInvocation.MyCommand.Path
$kbPath=Join-Path $scriptDir "..\references\knowledge-base.json"
$conceptMap=@{
    "生产价格"=@{"aliases"=@("平均利润","一般利润率");"related"=@("成本价格","资本有机构成");"difficulty"="★★★★★";"entries"=@("dk3-006")}
    "利润率下降"=@{"aliases"=@("利润率趋向下降的规律");"related"=@("资本有机构成","抵消因素");"difficulty"="★★★★★";"entries"=@("dk3-007","dk3-008")}
    "生息资本"=@{"aliases"=@("G-G'","借贷资本");"related"=@("利息","虚拟资本","信用");"difficulty"="★★★";"entries"=@("dk3-011")}
    "虚拟资本"=@{"aliases"=@();"related"=@("信用","银行资本","股票");"difficulty"="★★★";"entries"=@("dk3-012")}
    "级差地租"=@{"aliases"=@("级差地租I","级差地租II");"related"=@("绝对地租","土地肥力");"difficulty"="★★★★";"entries"=@("dk3-015","dk3-031","dk3-045")}
    "绝对地租"=@{"aliases"=@();"related"=@("级差地租","土地所有权");"difficulty"="★★★★★";"entries"=@("dk3-016")}
    "三位一体的公式"=@{"aliases"=@("Trinity Formula");"related"=@("拜物教","阶级","收入");"difficulty"="★★★★";"entries"=@("dk3-017")}
    "阶级"=@{"aliases"=@("三大阶级");"related"=@("工资","利润","地租");"difficulty"="★★★";"entries"=@("dk3-019","dk3-048")}
    "信用制度"=@{"aliases"=@("银行信用","商业信用");"related"=@("虚拟资本","流通手段");"difficulty"="★★★";"entries"=@("dk3-013","dk3-028")}
    "商业利润"=@{"aliases"=@("商人资本","商品经营资本");"related"=@("产业资本","剩余价值分配");"difficulty"="★★★";"entries"=@("dk3-009","dk3-039")}
}
$kb=Get-Content $kbPath -Raw|ConvertFrom-Json
if($Help){Write-Host "用法: -Query 概念名 | -Chapter 章名 | -ListConcepts | -Help";return}
if($ListConcepts){$conceptMap.GetEnumerator()|Sort-Object Name|%{Write-Host "$($_.Key) [$($_.Value.difficulty)]: $($_.Value.related -join ', ')"};return}
if($Query){$kb|Where-Object{$_.text -like "*$Query*"-or$_.concepts-contains$Query}|%{Write-Host "--- $($_.id) ---";Write-Host "$($_.chapter): $($_.heading)";Write-Host "概念: $($_.concepts -join ', ')";Write-Host ""}}
if($Chapter){$kb|Where-Object{$_.chapter-like"*$Chapter*"}|%{Write-Host "$($_.id): $($_.heading)"}}
