param(
    [string]$Query = "",
    [string]$Chapter = "",
    [switch]$ListConcepts,
    [switch]$Help
)

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$kbPath = Join-Path $scriptDir "..\references\knowledge-base.json"

# 概念映射表
$conceptMap = @{
    "货币资本循环" = @{
        "aliases" = @("G-G'", "形式I", "G…G'")
        "related" = @("生产资本循环", "商品资本循环", "产业资本")
        "difficulty" = "★★☆"
        "entries" = @("dk2-002", "dk2-003", "dk2-011", "dk2-014", "dk2-016")
    }
    "生产资本循环" = @{
        "aliases" = @("P-P", "形式II", "P…P")
        "related" = @("货币资本循环", "商品资本循环", "积累")
        "difficulty" = "★★☆"
        "entries" = @("dk2-003", "dk2-017", "dk2-020")
    }
    "商品资本循环" = @{
        "aliases" = @("W-W'", "形式III", "W'…W'")
        "related" = @("货币资本循环", "生产资本循环", "社会总资本")
        "difficulty" = "★★★"
        "entries" = @("dk2-003", "dk2-025", "dk2-027", "dk2-028")
    }
    "三种循环的统一" = @{
        "aliases" = @("资本循环", "循环的统一", "并列存在与继起性")
        "related" = @("货币资本循环", "生产资本循环", "商品资本循环")
        "difficulty" = "★★★"
        "entries" = @("dk2-031", "dk2-032", "dk2-033")
    }
    "固定资本" = @{
        "aliases" = @("固定资本")
        "related" = @("流动资本", "资本周转", "不变资本")
        "difficulty" = "★★☆"
        "entries" = @("dk2-006", "dk2-041", "dk2-042")
    }
    "流动资本" = @{
        "aliases" = @("流动资本")
        "related" = @("固定资本", "资本周转", "可变资本")
        "difficulty" = "★★☆"
        "entries" = @("dk2-006", "dk2-041")
    }
    "周转时间" = @{
        "aliases" = @("流通时间", "生产时间", "总周转时间")
        "related" = @("周转次数", "资本周转", "劳动期间")
        "difficulty" = "★★☆"
        "entries" = @("dk2-005", "dk2-040", "dk2-047")
    }
    "周转次数" = @{
        "aliases" = @("周转速度", "年周转次数")
        "related" = @("周转时间", "年剩余价值率")
        "difficulty" = "★★☆"
        "entries" = @("dk2-040")
    }
    "年剩余价值率" = @{
        "aliases" = @("M'", "年剩余价值率M'=m'n")
        "related" = @("周转次数", "可变资本周转", "剩余价值率")
        "difficulty" = "★★★"
        "entries" = @("dk2-048")
    }
    "流通费用" = @{
        "aliases" = @("纯粹流通费用", "保管费用", "运输费用")
        "related" = @("货币材料", "商品储备", "生产过程在流通中的继续")
        "difficulty" = "★★☆"
        "entries" = @("dk2-036", "dk2-037", "dk2-038", "dk2-039")
    }
    "两大部类" = @{
        "aliases" = @("第一部类", "第二部类", "I部类", "II部类")
        "related" = @("简单再生产", "扩大再生产", "I(v+m)=IIc")
        "difficulty" = "★★☆"
        "entries" = @("dk2-009", "dk2-052", "dk2-053")
    }
    "简单再生产" = @{
        "aliases" = @("简单再生产", "I(v+m)=IIc")
        "related" = @("两大部类", "扩大再生产", "固定资本补偿")
        "difficulty" = "★★★★★"
        "entries" = @("dk2-010", "dk2-052", "dk2-053", "dk2-054", "dk2-055")
    }
    "扩大再生产" = @{
        "aliases" = @("积累", "规模扩大的再生产", "I(v+m)>IIc")
        "related" = @("简单再生产", "潜在货币资本", "第一部类积累", "积累的物质条件")
        "difficulty" = "★★★★★"
        "entries" = @("dk2-020", "dk2-029", "dk2-056", "dk2-057", "dk2-058")
    }
    "经济危机" = @{
        "aliases" = @("危机", "生产过剩", "商品堆积")
        "related" = @("简单再生产", "扩大再生产", "资本循环中断")
        "difficulty" = "★★★"
        "entries" = @("dk2-004", "dk2-007", "dk2-019", "dk2-032")
    }
    "资本有机构成" = @{
        "aliases" = @("有机构成", "c:v")
        "related" = @("固定资本", "流动资本", "积累")
        "difficulty" = "★★★"
        "entries" = @("dk2-013")
    }
    "积累的物质条件" = @{
        "aliases" = @("物质条件", "剩余产品构成", "实物构成")
        "related" = @("扩大再生产", "潜在货币资本", "积累")
        "difficulty" = "★★★★"
        "entries" = @("dk2-029", "dk2-056")
    }
    "固定资本补偿" = @{
        "aliases" = @("折旧", "固定资本更新", "货币贮藏")
        "related" = @("简单再生产", "固定资本", "准备金")
        "difficulty" = "★★★★"
        "entries" = @("dk2-054", "dk2-024")
    }
    "斯密教条" = @{
        "aliases" = @("v+m分解", "斯密教条批判")
        "related" = @("两大部类", "简单再生产", "不变资本")
        "difficulty" = "★★★"
        "entries" = @("dk2-051")
    }
    "劳动期间" = @{
        "aliases" = @("劳动时间")
        "related" = @("生产时间", "周转时间", "预付资本")
        "difficulty" = "★★☆"
        "entries" = @("dk2-045")
    }
    "生产时间" = @{
        "aliases" = @("生产时间", "自然过程时间")
        "related" = @("劳动期间", "周转时间", "农业")
        "difficulty" = "★★☆"
        "entries" = @("dk2-046")
    }
    "潜在货币资本" = @{
        "aliases" = @("latent capital", "货币贮藏", "积累预备阶段")
        "related" = @("货币积累", "准备金", "扩大再生产")
        "difficulty" = "★★★"
        "entries" = @("dk2-023", "dk2-024")
    }
    "G-A" = @{
        "aliases" = @("购买劳动力", "工资形式")
        "related" = @("劳动力商品", "剩余价值生产", "资本循环")
        "difficulty" = "★★★"
        "entries" = @("dk2-015", "dk2-018")
    }
}

# 加载KB
$kb = Get-Content $kbPath -Raw | ConvertFrom-Json

function Show-Help {
    Write-Host @"
资本论第二卷·知识库查询工具

用法:
  -Query "概念名"     搜索相关知识条目
  -Chapter "章名"     按章节筛选
  -ListConcepts       列出所有概念
  -Help               显示本帮助

示例:
  .\query_kb.ps1 -Query "剩余价值"
  .\query_kb.ps1 -Chapter "简单再生产"
  .\query_kb.ps1 -ListConcepts
"@
}

function Show-Concepts {
    Write-Host "`n=== 概念映射表（共 $($conceptMap.Count) 个概念） ===`n"
    $conceptMap.GetEnumerator() | Sort-Object Name | ForEach-Object {
        $name = $_.Key
        $info = $_.Value
        $entries = $info.entries -join ", "
        Write-Host "  $name [$($info.difficulty)]"
        Write-Host "    关联概念: $($info.related -join ', ')"
        Write-Host "    对应条目: $entries"
        Write-Host ""
    }
}

function Search-Query {
    param($q)
    $results = @()
    $qLower = $q.ToLower()
    
    # 搜索text字段
    $results += $kb | Where-Object { $_.text.ToLower().Contains($qLower) }
    # 搜索concepts字段
    $results += $kb | Where-Object {
        $_.concepts -contains $q -or
        ($_.concepts | ForEach-Object { $_.ToLower() }) -contains $qLower
    }
    # 搜索概念别名
    $conceptMap.GetEnumerator() | ForEach-Object {
        if ($_.Key.ToLower() -eq $qLower -or $_.Value.aliases -contains $q) {
            $results += $kb | Where-Object { $_.id -in $_.Value.entries }
        }
    }
    
    $results = $results | Sort-Object id -Unique
    
    if ($results.Count -eq 0) {
        Write-Host "未找到与 '$q' 相关的结果。"
        return
    }
    
    Write-Host "`n找到 $($results.Count) 条相关结果:`n"
    $results | ForEach-Object {
        Write-Host "--- $($_.id) ---"
        Write-Host "章节: $($_.chapter)"
        Write-Host "标题: $($_.heading)"
        Write-Host "概念: $($_.concepts -join ', ')"
        Write-Host "确信度: $($_.confidence)"
        Write-Host "正文: $($_.text.Substring(0, [Math]::Min(150, $_.text.Length)))$(if($_.text.Length -gt 150){'...'})"
        Write-Host ""
    }
}

function Search-Chapter {
    param($ch)
    $results = $kb | Where-Object { $_.chapter -like "*$ch*" }
    
    if ($results.Count -eq 0) {
        Write-Host "未找到章节包含 '$ch' 的结果。"
        return
    }
    
    Write-Host "`n找到 $($results.Count) 条相关结果:`n"
    $results | ForEach-Object {
        Write-Host "--- $($_.id) ---"
        Write-Host "章节: $($_.chapter)"
        Write-Host "标题: $($_.heading)"
        Write-Host "概念: $($_.concepts -join ', ')"
        Write-Host ""
    }
}

# Main
if ($Help) { Show-Help; return }
if ($ListConcepts) { Show-Concepts; return }
if ($Query) { Search-Query $Query; return }
if ($Chapter) { Search-Chapter $Chapter; return }

# No params
Show-Help
