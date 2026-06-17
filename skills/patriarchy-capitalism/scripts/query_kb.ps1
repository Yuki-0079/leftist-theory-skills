param(
    [string]$Query = "",
    [string]$Chapter = "",
    [switch]$ListConcepts,
    [switch]$Help
)

# Path settings
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$kbPath = Join-Path $scriptDir "..\references\knowledge-base.json"

# Concept map
$conceptMap = @{
    # ===== 理论基石 =====
    "父权制资本主义" = @{
        "aliases" = @("patriarchal capitalism", "patriarchal capitalism")
        "related" = @("二元论", "资本主义的外部", "统一理论")
        "difficulty" = "★★★"
        "entries" = @("pc-010", "pc-019", "pc-043", "pc-044")
    }
    "马克思主义女权主义" = @{
        "aliases" = @("Marxist feminism", "马克思主义女性主义")
        "related" = @("父权制资本主义", "二元论", "唯物主义分析")
        "difficulty" = "★★☆"
        "entries" = @("pc-001", "pc-007", "pc-010", "pc-020", "pc-047")
    }
    "市场的外部" = @{
        "aliases" = @("outside of the market", "外部")
        "related" = @("家庭", "自然", "资本主义的外部")
        "difficulty" = "★★★"
        "entries" = @("pc-009", "pc-014", "pc-053")
    }
    "二元论" = @{
        "aliases" = @("dualism", "二重机制论")
        "related" = @("父权制资本主义", "统一理论", "沃尔拜五种分类")
        "difficulty" = "★★★"
        "entries" = @("pc-043", "pc-045", "pc-046")
    }
    "统一理论" = @{
        "aliases" = @("unitary theory", "一元论")
        "related" = @("二元论", "资本主义一元论", "功能主义")
        "difficulty" = "★★★"
        "entries" = @("pc-043", "pc-044")
    }
    "唯物主义分析" = @{
        "aliases" = @("materialist analysis", "唯物论")
        "related" = @("马克思主义女权主义", "性统治的物质基础")
        "difficulty" = "★★☆"
        "entries" = @("pc-021", "pc-029")
    }

    # ===== 再生产劳动 =====
    "再生产劳动" = @{
        "aliases" = @("reproductive labor", "无偿劳动", "unpaid labor")
        "related" = @("家务劳动", "以爱之名的劳动", "再生产费用")
        "difficulty" = "★★☆"
        "entries" = @("pc-002", "pc-003", "pc-022")
    }
    "家务劳动" = @{
        "aliases" = @("domestic labor", "housework")
        "related" = @("再生产劳动", "家庭内部生产方式", "道菲")
        "difficulty" = "★★☆"
        "entries" = @("pc-022", "pc-023", "pc-024")
    }
    "以爱之名的劳动" = @{
        "aliases" = @("a labor of love", "爱的劳动")
        "related" = @("母性意识形态", "家务劳动", "无偿劳动")
        "difficulty" = "★★☆"
        "entries" = @("pc-024")
    }
    "生产至上主义" = @{
        "aliases" = @("productionism", "生产还原论")
        "related" = @("再生产劳动", "生产与再生产的辩证法", "批判经济学")
        "difficulty" = "★★★"
        "entries" = @("pc-034", "pc-036")
    }
    "生产与再生产的辩证法" = @{
        "aliases" = @("dialectics of production and reproduction")
        "related" = @("生产至上主义", "再生产方式", "萨克斯三段论")
        "difficulty" = "★★★"
        "entries" = @("pc-034", "pc-036")
    }
    "再生产费用" = @{
        "aliases" = @("reproductive costs", "再生产费用负担")
        "related" = @("再生产劳动", "家庭工资神话", "中断-再就业陷阱")
        "difficulty" = "★★☆"
        "entries" = @("pc-039", "pc-040")
    }

    # ===== 父权制分析 =====
    "父权制" = @{
        "aliases" = @("patriarchy", "patriarchy")
        "related" = @("父权制的物质基础", "家庭内部生产方式", "性统治")
        "difficulty" = "★★☆"
        "entries" = @("pc-029", "pc-030", "pc-031")
    }
    "家庭内部生产方式" = @{
        "aliases" = @("domestic mode of production", "道菲")
        "related" = @("父权制", "道菲", "女性阶级")
        "difficulty" = "★★★"
        "entries" = @("pc-032", "pc-033")
    }
    "女性阶级" = @{
        "aliases" = @("women-class", "性阶级")
        "related" = @("家庭内部生产方式", "道菲", "性阶级")
        "difficulty" = "★★☆"
        "entries" = @("pc-033")
    }
    "被倒戈的革命" = @{
        "aliases" = @("betrayed revolution", "背叛的革命")
        "related" = @("资产阶级女性解放思想", "男性的解放")
        "difficulty" = "★☆☆"
        "entries" = @("pc-008")
    }
    "世代间的统治" = @{
        "aliases" = @("generational domination", "世代统治")
        "related" = @("父权制", "孩子的反叛", "再生产费用")
        "difficulty" = "★★★"
        "entries" = @("pc-041", "pc-042")
    }

    # ===== 历史分析 =====
    "维多利亚时代的妥协" = @{
        "aliases" = @("Victorian compromise", "第一期妥协")
        "related" = @("历史性妥协", "近代家庭", "工业化")
        "difficulty" = "★★☆"
        "entries" = @("pc-048", "pc-049")
    }
    "第二次妥协" = @{
        "aliases" = @("second compromise", "第二期妥协")
        "related" = @("非全日制劳动", "家庭主妇劳动者", "M字形就业")
        "difficulty" = "★★☆"
        "entries" = @("pc-050")
    }
    "M字形就业" = @{
        "aliases" = @("M-shaped employment", "M字型就业")
        "related" = @("家庭主妇劳动者", "中断-再就业陷阱", "非全日制劳动")
        "difficulty" = "★☆☆"
        "entries" = @("pc-004", "pc-050")
    }
    "非全日制劳动" = @{
        "aliases" = @("part-time labor", "非正规劳动")
        "related" = @("第二次妥协", "家庭主妇劳动者", "中断-再就业陷阱")
        "difficulty" = "★★☆"
        "entries" = @("pc-050")
    }
    "中断-再就业陷阱" = @{
        "aliases" = @("interruption-reemployment trap")
        "related" = @("M字形就业", "非全日制劳动", "再生产费用")
        "difficulty" = "★★☆"
        "entries" = @("pc-051", "pc-052")
    }
    "家庭主妇劳动者" = @{
        "aliases" = @("housewife worker", "主妇劳动者")
        "related" = @("非全日制劳动", "M字形就业", "第二次妥协")
        "difficulty" = "★☆☆"
        "entries" = @("pc-050")
    }

    # ===== 批判与展望 =====
    "批判经济学" = @{
        "aliases" = @("critique of economics")
        "related" = @("生产至上主义", "劳动的颠倒", "大熊信行")
        "difficulty" = "★★☆"
        "entries" = @("pc-054")
    }
    "女权主义的另一种选择" = @{
        "aliases" = @("feminist alternative", "另一种选择")
        "related" = @("批判经济学", "资本主义的外部", "再生产劳动的分配")
        "difficulty" = "★★★"
        "entries" = @("pc-053", "pc-054", "pc-055")
    }
    "全球性劳动力的主妇化" = @{
        "aliases" = @("global housewifization", "劳动力的主妇化")
        "related" = @("后工业化", "性别分工的重组", "沃尔霍夫")
        "difficulty" = "★★★"
        "entries" = @("pc-055")
    }
    "再生产劳动的分配问题" = @{
        "aliases" = @("allocation of reproductive labor")
        "related" = @("公共化选项", "市场化选项", "亚洲型解决方式")
        "difficulty" = "★★☆"
        "entries" = @("pc-003")
    }
}

# Help
if ($Help) {
    Write-Host @"

  父权制与资本主义 — KB 查询工具

  用法:
    .\query_kb.ps1 -Query "概念名"      # 查询概念
    .\query_kb.ps1 -Chapter "章节名"    # 按章节检索
    .\query_kb.ps1 -ListConcepts       # 列出所有概念
    .\query_kb.ps1 -Help               # 显示帮助

  示例:
    .\query_kb.ps1 -Query "父权制资本主义"
    .\query_kb.ps1 -Chapter "第六章"
    .\query_kb.ps1 -ListConcepts | Select-Object -First 20

"@
    exit
}

# Load KB
if (-not (Test-Path $kbPath)) {
    Write-Error "知识库文件未找到: $kbPath"
    exit 1
}
$kb = Get-Content $kbPath -Raw | ConvertFrom-Json

# List all concepts
if ($ListConcepts) {
    Write-Host "`n父权制与资本主义 — 概念列表" -ForegroundColor Cyan
    Write-Host "================================" -ForegroundColor Cyan
    $conceptMap.Keys | Sort-Object | ForEach-Object {
        $c = $_
        $info = $conceptMap[$c]
        $entryCount = $info.entries.Count
        Write-Host "[$($info.difficulty)] $c ($entryCount 条)" -ForegroundColor Yellow
        if ($info.aliases.Count -gt 0) {
            Write-Host "    别名: $($info.aliases -join ', ')" -ForegroundColor Gray
        }
    }
    Write-Host "`n共 $($conceptMap.Keys.Count) 个概念" -ForegroundColor Cyan
    exit
}

# Query by chapter
if ($Chapter) {
    Write-Host "`n查询章节: $Chapter" -ForegroundColor Cyan
    Write-Host "=======================" -ForegroundColor Cyan
    $results = $kb | Where-Object { $_.chapter -like "*$Chapter*" }
    if ($results.Count -eq 0) {
        Write-Host "未找到匹配条目" -ForegroundColor Red
    } else {
        $results | ForEach-Object {
            Write-Host "[$($_.id)] $($_.chapter)" -ForegroundColor Green
            Write-Host "  概念: $($_.concepts -join ', ')" -ForegroundColor Yellow
            Write-Host "  confidence: $($_.confidence)" -ForegroundColor Gray
            $textPreview = if ($_.text.Length -gt 150) { $_.text.Substring(0, 150) + "..." } else { $_.text }
            Write-Host "  $textPreview" -ForegroundColor White
            Write-Host "  ---"
        }
        Write-Host "`n共 $($results.Count) 条结果" -ForegroundColor Cyan
    }
    exit
}

# Query by keyword
if ($Query) {
    Write-Host "`n查询: $Query" -ForegroundColor Cyan
    Write-Host "=============" -ForegroundColor Cyan
    
    # Search in text and concepts
    $results = $kb | Where-Object {
        $_.text -like "*$Query*" -or
        ($_.concepts | Where-Object { $_ -like "*$Query*" }) -or
        $_.heading -like "*$Query*"
    }
    
    # Also check concept map aliases
    $conceptMatch = $conceptMap.Keys | Where-Object { $_ -like "*$Query*" }
    if ($conceptMatch.Count -eq 0) {
        $conceptMatch = $conceptMap.Keys | Where-Object {
            $info = $conceptMap[$_]
            $info.aliases | Where-Object { $_ -like "*$Query*" }
        }
    }
    
    if ($results.Count -eq 0 -and $conceptMatch.Count -eq 0) {
        Write-Host "未找到匹配条目" -ForegroundColor Red
    } else {
        if ($conceptMatch.Count -gt 0) {
            Write-Host "`n匹配概念:" -ForegroundColor Magenta
            $conceptMatch | ForEach-Object {
                $info = $conceptMap[$_]
                Write-Host "  $_ [$($info.difficulty)]" -ForegroundColor Yellow
                Write-Host "  相关概念: $($info.related -join ', ')" -ForegroundColor Gray
                if ($info.aliases.Count -gt 0) {
                    Write-Host "  别名: $($info.aliases -join ', ')" -ForegroundColor Gray
                }
            }
        }
        
        Write-Host "`n匹配条目:" -ForegroundColor Magenta
        $results | ForEach-Object {
            Write-Host "[$($_.id)] $($_.chapter)" -ForegroundColor Green
            Write-Host "  概念: $($_.concepts -join ', ')" -ForegroundColor Yellow
            Write-Host "  confidence: $($_.confidence)" -ForegroundColor Gray
            $textPreview = if ($_.text.Length -gt 200) { $_.text.Substring(0, 200) + "..." } else { $_.text }
            Write-Host "  $textPreview" -ForegroundColor White
            Write-Host "  ---"
        }
        Write-Host "`n共 $($results.Count) 条结果" -ForegroundColor Cyan
    }
    exit
}

# Default: show summary
Write-Host @"

父权制与资本主义 — KB 查询工具

用法:
  .\query_kb.ps1 -Query "概念名"      # 查询概念
  .\query_kb.ps1 -Chapter "章节名"    # 按章节检索
  .\query_kb.ps1 -ListConcepts       # 列出所有概念
  .\query_kb.ps1 -Help               # 显示帮助

知识库统计:
  条目数: $($kb.Count)

"@
