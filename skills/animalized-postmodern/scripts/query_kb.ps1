param(
    [string]$Query = "",
    [string]$Chapter = "",
    [switch]$ListConcepts,
    [switch]$Help
)

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$kbPath = Join-Path $scriptDir "..\references\knowledge-base.json"

$conceptMap = @{
    # 理论基石
    "数据库消费" = @{
        "aliases" = @("database consumption", "数据库消费")
        "related" = @("双层结构", "萌要素", "拟像", "故事消费")
        "difficulty" = "★★★"
        "entries" = @("ap-006", "ap-008", "ap-013")
    }
    "双层结构" = @{
        "aliases" = @("double-layer structure", "二重构造", "两层构造")
        "related" = @("数据库消费", "拟像", "大型非叙事")
        "difficulty" = "★★★"
        "entries" = @("ap-006", "ap-008", "ap-013", "ap-016")
    }
    "动物化" = @{
        "aliases" = @("animalization", "动物化")
        "related" = @("科耶夫", "欲望与需求", "没有他者的社会")
        "difficulty" = "★★★"
        "entries" = @("ap-011", "ap-012")
    }
    "大叙事的凋零" = @{
        "aliases" = @("decline of grand narratives", "宏大叙事的终结")
        "related" = @("李欧塔", "后现代", "清高主义")
        "difficulty" = "★★☆"
        "entries" = @("ap-004", "ap-005")
    }
    "故事消费" = @{
        "aliases" = @("story consumption", "物语消费")
        "related" = @("大塚英志", "数据库消费", "大叙事")
        "difficulty" = "★★☆"
        "entries" = @("ap-005")
    }
    "拟像" = @{
        "aliases" = @("simulacra", "拟仿物")
        "related" = @("布希亚", "数据库", "二次创作")
        "difficulty" = "★★☆"
        "entries" = @("ap-002", "ap-009")
    }
    "清高主义" = @{
        "aliases" = @("snobbery", "snob")
        "related" = @("虚构的时代", "科耶夫", "犬儒主义")
        "difficulty" = "★★☆"
        "entries" = @("ap-010")
    }
    "萌要素" = @{
        "aliases" = @("moe elements", "萌え要素")
        "related" = @("数据库消费", "萌", "跨媒体制作")
        "difficulty" = "★★☆"
        "entries" = @("ap-007")
    }
    "虚构的时代" = @{
        "aliases" = @("age of fiction", "fiction时代")
        "related" = @("动物的时代", "清高主义", "御宅族的三个世代")
        "difficulty" = "★★★"
        "entries" = @("ap-010", "ap-017", "ap-018")
    }
    "动物的时代" = @{
        "aliases" = @("age of animal", "animal时代")
        "related" = @("虚构的时代", "动物化", "数据库消费")
        "difficulty" = "★★★"
        "entries" = @("ap-011", "ap-012")
    }
    "御宅族" = @{
        "aliases" = @("otaku", "御宅族系文化")
        "related" = @("二次创作", "拟日本", "数据库消费")
        "difficulty" = "★☆☆"
        "entries" = @("ap-001", "ap-002", "ap-017", "ap-018")
    }
    "拟日本" = @{
        "aliases" = @("pseudo-Japan", "pseudo-japan")
        "related" = @("御宅族", "日本文化身份", "后现代")
        "difficulty" = "★★☆"
        "entries" = @("ap-003")
    }
    "二次创作" = @{
        "aliases" = @("derivative works", "二次创作", "同人")
        "related" = @("御宅族", "拟像", "数据库")
        "difficulty" = "★☆☆"
        "entries" = @("ap-001", "ap-002")
    }
    "超平面性" = @{
        "aliases" = @("hyperflatness", "超扁平")
        "related" = @("后现代美学", "多重人格", "村上隆")
        "difficulty" = "★★☆"
        "entries" = @("ap-015")
    }
    "解离" = @{
        "aliases" = @("dissociation", "解离")
        "related" = @("多重人格", "双层结构", "后现代主体")
        "difficulty" = "★★★"
        "entries" = @("ap-014", "ap-016")
    }
    "大型非叙事" = @{
        "aliases" = @("grand non-narrative", "grand non-narrative")
        "related" = @("数据库", "小故事", "双层结构")
        "difficulty" = "★★★"
        "entries" = @("ap-013")
    }
    "跨媒体制作" = @{
        "aliases" = @("media mix", "跨媒体")
        "related" = @("数据库消费", "萌要素", "原创与复制")
        "difficulty" = "★★☆"
        "entries" = @("ap-007", "ap-008")
    }
}

if ($Help) {
    Write-Host @"

  动物化的后现代 — KB 查询工具

  用法:
    .\query_kb.ps1 -Query "概念名"      # 查询概念
    .\query_kb.ps1 -Chapter "章节名"    # 按章节检索
    .\query_kb.ps1 -ListConcepts       # 列出所有概念
    .\query_kb.ps1 -Help               # 显示帮助

  示例:
    .\query_kb.ps1 -Query "数据库消费"
    .\query_kb.ps1 -Chapter "第二章"
    .\query_kb.ps1 -ListConcepts

"@
    exit
}

if (-not (Test-Path $kbPath)) {
    Write-Error "KB not found: $kbPath"
    exit 1
}
$kb = Get-Content $kbPath -Raw | ConvertFrom-Json

if ($ListConcepts) {
    Write-Host "`n动物化的后现代 — 概念列表" -ForegroundColor Cyan
    $conceptMap.Keys | Sort-Object | ForEach-Object {
        $c = $_; $info = $conceptMap[$c]
        Write-Host "[$($info.difficulty)] $c ($($info.entries.Count) 条)" -ForegroundColor Yellow
        if ($info.aliases.Count -gt 0) { Write-Host "    别名: $($info.aliases -join ', ')" -ForegroundColor Gray }
    }
    Write-Host "`n共 $($conceptMap.Keys.Count) 个概念" -ForegroundColor Cyan
    exit
}

if ($Chapter) {
    Write-Host "`n查询章节: $Chapter" -ForegroundColor Cyan
    $results = $kb | Where-Object { $_.chapter -like "*$Chapter*" }
    if ($results.Count -eq 0) { Write-Host "无匹配" -ForegroundColor Red; exit }
    $results | ForEach-Object {
        Write-Host "[$($_.id)] $($_.chapter)" -ForegroundColor Green
        Write-Host "  概念: $($_.concepts -join ', ')" -ForegroundColor Yellow
        $t = if ($_.text.Length -gt 150) { $_.text.Substring(0,150) + "..." } else { $_.text }
        Write-Host "  $t" -ForegroundColor White
        Write-Host "  ---"
    }
    Write-Host "`n共 $($results.Count) 条" -ForegroundColor Cyan
    exit
}

if ($Query) {
    Write-Host "`n查询: $Query" -ForegroundColor Cyan
    $results = $kb | Where-Object { $_.text -like "*$Query*" -or ($_.concepts | Where-Object { $_ -like "*$Query*" }) -or $_.heading -like "*$Query*" }
    $conceptMatch = $conceptMap.Keys | Where-Object { $_ -like "*$Query*" }
    if ($conceptMatch.Count -eq 0) {
        $conceptMatch = $conceptMap.Keys | Where-Object { ($conceptMap[$_].aliases | Where-Object { $_ -like "*$Query*" }) }
    }
    if ($results.Count -eq 0 -and $conceptMatch.Count -eq 0) { Write-Host "无匹配" -ForegroundColor Red; exit }
    if ($conceptMatch.Count -gt 0) {
        Write-Host "`n匹配概念:" -ForegroundColor Magenta
        $conceptMatch | ForEach-Object { $info = $conceptMap[$_]; Write-Host "  $_ [$($info.difficulty)]" -ForegroundColor Yellow; Write-Host "  相关概念: $($info.related -join ', ')" -ForegroundColor Gray }
    }
    Write-Host "`n匹配条目:" -ForegroundColor Magenta
    $results | ForEach-Object {
        Write-Host "[$($_.id)] $($_.chapter)" -ForegroundColor Green
        Write-Host "  概念: $($_.concepts -join ', ')" -ForegroundColor Yellow
        $t = if ($_.text.Length -gt 200) { $_.text.Substring(0,200) + "..." } else { $_.text }
        Write-Host "  $t" -ForegroundColor White
        Write-Host "  ---"
    }
    Write-Host "`n共 $($results.Count) 条" -ForegroundColor Cyan
    exit
}

Write-Host @"

  动物化的后现代 — KB 查询工具

  用法: .\query_kb.ps1 -Query "概念名"
         .\query_kb.ps1 -Chapter "章节名"
         .\query_kb.ps1 -ListConcepts
         .\query_kb.ps1 -Help

  共 $($kb.Count) 条

"@
