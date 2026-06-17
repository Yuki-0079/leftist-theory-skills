param(
    [string]$Query = "",
    [string]$Chapter = "",
    [switch]$ListConcepts,
    [switch]$Help
)

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$kbPath = Join-Path $scriptDir "..\references\knowledge-base.json"

$conceptMap = @{
    "意识形态幻象" = @{
        "aliases" = @("ideological fantasy", "幻象", "fantasy")
        "related" = @("狗智主义", "现实支撑物", "实在界")
        "difficulty" = "★★★"
        "entries" = @("zs-023", "zs-026")
    }
    "征兆" = @{
        "aliases" = @("symptom", "社会性征兆")
        "related" = @("征候", "形式分析", "商品恋物癖")
        "difficulty" = "★★★"
        "entries" = @("zs-019", "zs-021", "zs-028")
    }
    "征候" = @{
        "aliases" = @("sinthome", "享乐结晶体")
        "related" = @("征兆", "原乐", "剩余快感")
        "difficulty" = "★★★★"
        "entries" = @("zs-030")
    }
    "狗智主义" = @{
        "aliases" = @("cynicism", "启蒙的虚假意识", "犬儒主义")
        "related" = @("意识形态幻象", "后意识形态", "信仰的客观性")
        "difficulty" = "★★☆"
        "entries" = @("zs-022")
    }
    "缝合点" = @{
        "aliases" = @("point de capiton", "纽结点", "quilting point")
        "related" = @("主人能指", "漂浮的能指", "回溯性")
        "difficulty" = "★★★"
        "entries" = @("zs-031", "zs-033")
    }
    "崇高客体" = @{
        "aliases" = @("sublime object", "原质")
        "related" = @("小客体", "两种死亡之间", "商品恋物癖")
        "difficulty" = "★★★"
        "entries" = @("zs-039", "zs-035")
    }
    "回溯性" = @{
        "aliases" = @("retroactivity", "apres-coup", "事后")
        "related" = @("缝合点", "移情", "真理源自误认")
        "difficulty" = "★★★"
        "entries" = @("zs-028", "zs-033")
    }
    "真理源自误认" = @{
        "aliases" = @("truth from misrecognition", "错误逻辑")
        "related" = @("回溯性", "移情", "重复")
        "difficulty" = "★★★"
        "entries" = @("zs-028", "zs-029")
    }
    "实在界" = @{
        "aliases" = @("the Real", "实在界的内核")
        "related" = @("幻象", "对抗", "欲望")
        "difficulty" = "★★★"
        "entries" = @("zs-026", "zs-014")
    }
    "原乐" = @{
        "aliases" = @("jouissance", "享乐", "剩余快感", "plus-de-jouir")
        "related" = @("剩余快感", "剩余价值", "意识形态快感")
        "difficulty" = "★★★★"
        "entries" = @("zs-027", "zs-041")
    }
    "对抗" = @{
        "aliases" = @("antagonism", "根本对抗")
        "related" = @("实在界", "激进的民主", "社会性征兆")
        "difficulty" = "★★★"
        "entries" = @("zs-016", "zs-021")
    }
    "两种死亡之间" = @{
        "aliases" = @("between two deaths", "符号性死亡")
        "related" = @("崇高客体", "安提戈涅")
        "difficulty" = "★★★★"
        "entries" = @("zs-035")
    }
    "信仰的客观性" = @{
        "aliases" = @("客观信仰", "外在化")
        "related" = @("狗智主义", "帕斯卡尔", "转经轮")
        "difficulty" = "★★☆"
        "entries" = @("zs-024")
    }
    "被迫选择" = @{
        "aliases" = @("choix force", "forced choice", "自由选择悖论")
        "related" = @("自由", "实在界", "康德")
        "difficulty" = "★★★"
        "entries" = @("zs-036")
    }
    "否定之否定" = @{
        "aliases" = @("negation of negation", "精神是根骨头")
        "related" = @("黑格尔", "对抗", "同一性")
        "difficulty" = "★★★★"
        "entries" = @("zs-038")
    }
    "大对体" = @{
        "aliases" = @("big Other", "符号秩序", "大他者")
        "related" = @("S(A/)", "缝合点", "匮乏")
        "difficulty" = "★★★"
        "entries" = @("zs-024", "zs-031", "zs-037")
    }
    "S(A/)" = @{
        "aliases" = @("大对体中匮乏的能指")
        "related" = @("大对体", "小客体", "符号秩序")
        "difficulty" = "★★★★"
        "entries" = @("zs-037")
    }
    "穿越幻象" = @{
        "aliases" = @("traversing the fantasy", "穿越社会幻象")
        "related" = @("幻象", "征候", "认同")
        "difficulty" = "★★★★"
        "entries" = @("zs-034")
    }
    "商品形式之无意识" = @{
        "aliases" = @("商品形式", "真实抽象", "佐恩雷特尔")
        "related" = @("征兆", "商品恋物癖", "超验主体")
        "difficulty" = "★★★"
        "entries" = @("zs-020")
    }
    "形式分析" = @{
        "aliases" = @("form analysis", "形式vs内容")
        "related" = @("征兆", "梦的运作", "商品形式")
        "difficulty" = "★★★"
        "entries" = @("zs-019")
    }
    "移情" = @{
        "aliases" = @("transference", "转移")
        "related" = @("回溯性", "缝合点", "真理源自误认")
        "difficulty" = "★★★"
        "entries" = @("zs-028", "zs-033")
    }
    "律令的淫秽面" = @{
        "aliases" = @("obscene underside", "超我")
        "related" = @("原乐", "律令", "卡夫卡")
        "difficulty" = "★★★★"
        "entries" = @("zs-025", "zs-041")
    }
    "小客体" = @{
        "aliases" = @("objet petit a", "客体a", "欲望的客体成因")
        "related" = @("崇高客体", "S(A/)", "刚性指称词")
        "difficulty" = "★★★★"
        "entries" = @("zs-032", "zs-037")
    }
}

# Help
if ($Help) {
    Write-Host @"
╔══════════════════════════════════════════════╗
║   齐泽克《意识形态的崇高客体》知识库查询      ║
╠══════════════════════════════════════════════╣
║  用法:                                       ║
║    .\query_kb.ps1 -Query "概念名"             ║
║    .\query_kb.ps1 -Chapter "章节名"           ║
║    .\query_kb.ps1 -ListConcepts              ║
║    .\query_kb.ps1 -Help                      ║
╚══════════════════════════════════════════════╝
"@
    exit
}

# Check if KB exists
if (-not (Test-Path $kbPath)) {
    Write-Error "知识库文件未找到: $kbPath"
    exit 1
}

$kb = Get-Content $kbPath -Raw -Encoding UTF8 | ConvertFrom-Json

# List all concepts
if ($ListConcepts) {
    Write-Host "=== 核心概念列表 ===" -ForegroundColor Cyan
    $conceptMap.Keys | Sort-Object | ForEach-Object {
        $c = $_
        $info = $conceptMap[$c]
        $diff = $info.difficulty
        $entries = $info.entries -join ", "
        Write-Host "[$diff] $c" -ForegroundColor Yellow
        if ($info.aliases.Count -gt 0) {
            $aliases = $info.aliases -join ", "
            Write-Host "     别名: $aliases"
        }
        Write-Host "     条目: $entries"
    }
    exit
}

# Query by chapter
if ($Chapter) {
    Write-Host "=== 章节检索: $Chapter ===" -ForegroundColor Cyan
    $results = $kb | Where-Object { $_.chapter -like "*$Chapter*" }
    if ($results.Count -eq 0) {
        Write-Host "未找到匹配条目。"
    } else {
        $results | ForEach-Object {
            Write-Host "[$($_.id)] $($_.concepts -join ', ')" -ForegroundColor Yellow
            Write-Host "  章节: $($_.chapter)"
            if ($_.heading) { Write-Host "  标题: $($_.heading)" }
            Write-Host "  置信度: $($_.confidence)"
            Write-Host "  text: $($_.text.Substring(0, [Math]::Min(150, $_.text.Length)))$(if($_.text.Length -gt 150){'...'})"
            Write-Host ""
        }
    }
    Write-Host "共 $($results.Count) 条匹配"
    exit
}

# Query by keyword
if ($Query) {
    Write-Host "=== 关键词检索: $Query ===" -ForegroundColor Cyan
    $results = $kb | Where-Object {
        $_.text -like "*$Query*" -or
        ($_.concepts -join " ") -like "*$Query*" -or
        $_.chapter -like "*$Query*" -or
        $_.heading -like "*$Query*"
    }
    if ($results.Count -eq 0) {
        # Check if it's a known concept
        if ($conceptMap.ContainsKey($Query)) {
            $info = $conceptMap[$Query]
            Write-Host "概念 '$Query' 存在于概念映射中，建议检索其近义词:" -ForegroundColor Green
            $info.aliases | ForEach-Object { Write-Host "  - $_" }
            $info.related | ForEach-Object { Write-Host "  相关概念: $_" }
        } else {
            Write-Host "未找到匹配条目。"
        }
    } else {
        $results | ForEach-Object {
            Write-Host "[$($_.id)] $($_.concepts -join ', ')" -ForegroundColor Yellow
            Write-Host "  章节: $($_.chapter)"
            if ($_.heading) { Write-Host "  标题: $($_.heading)" }
            Write-Host "  置信度: $($_.confidence)"
            Write-Host "  text: $($_.text.Substring(0, [Math]::Min(200, $_.text.Length)))$(if($_.text.Length -gt 200){'...'})"
            Write-Host ""
        }
    }
    Write-Host "共 $($results.Count) 条匹配"
    exit
}

# Default: show summary
Write-Host "╔══════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║  齐泽克《意识形态的崇高客体》知识库      ║" -ForegroundColor Cyan
Write-Host "╠══════════════════════════════════════════╣" -ForegroundColor Cyan
Write-Host "║  条目总数: $($kb.Count)" -ForegroundColor Cyan
$concepts = $kb | ForEach-Object { $_.concepts } | Where-Object { $_ } | ForEach-Object { $_ } | Sort-Object -Unique
Write-Host "║  概念标签: $($concepts.Count) 个" -ForegroundColor Cyan
Write-Host "║  章节分布: " -ForegroundColor Cyan
$kb | Group-Object Chapter | Sort-Object Name | ForEach-Object {
    Write-Host "║    $($_.Name): $($_.Count) 条"
}
Write-Host "╚══════════════════════════════════════════╝" -ForegroundColor Cyan
