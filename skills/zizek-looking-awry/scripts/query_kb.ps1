param(
    [string]$Query = "",
    [string]$Chapter = "",
    [switch]$ListConcepts,
    [switch]$Help
)

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$kbPath = Join-Path $scriptDir "..\references\knowledge-base.json"

$conceptMap = @{
    "斜目而视" = @{
        "aliases" = @("looking awry", "方法论")
        "related" = @("芝诺悖论", "形式分析")
        "difficulty" = "★★☆"
        "entries" = @("la-001")
    }
    "作为客体的凝视" = @{
        "aliases" = @("gaze as object", "希区柯克式斑点", "斑点")
        "related" = @("无主体的主体性", "口唇/肛门/阳物")
        "difficulty" = "★★★"
        "entries" = @("la-003", "la-005")
    }
    "活死人的回归" = @{
        "aliases" = @("return of the dead", "两种死亡之间", "符号性债务")
        "related" = @("驱力", "未完成的葬礼")
        "difficulty" = "★★☆"
        "entries" = @("la-002")
    }
    "口唇/肛门/阳物" = @{
        "aliases" = @("三阶段", "oral/anal/phallic", "电影形式类型学")
        "related" = @("希区柯克", "蒙太奇")
        "difficulty" = "★★★"
        "entries" = @("la-005")
    }
    "驱力" = @{
        "aliases" = @("drive", "驱力vs欲望")
        "related" = @("活死人", "终结者")
        "difficulty" = "★★★"
        "entries" = @("la-002")
    }
    "作为客体的声音" = @{
        "aliases" = @("voice as object", "幻听语音")
        "related" = @("意识形态症候", "巴西")
        "difficulty" = "★★★"
        "entries" = @("la-008")
    }
    "时间扭曲" = @{
        "aliases" = @("时间性", "反向叙事", "回溯性")
        "related" = @("宿命主义", "品特")
        "difficulty" = "★★★"
        "entries" = @("la-006")
    }
    "大对体的无知" = @{
        "aliases" = @("无知法则", "公开秘密")
        "related" = @("礼仪", "失窃的信")
        "difficulty" = "★★★"
        "entries" = @("la-004")
    }
    "淫秽补充" = @{
        "aliases" = @("obscene supplement", "潜规则")
        "related" = @("形式民主", "符号权威")
        "difficulty" = "★★★"
        "entries" = @("la-009", "la-010")
    }
    "感官快感" = @{
        "aliases" = @("jouis-sense", "意识形态快感")
        "related" = @("巴西", "背景音乐")
        "difficulty" = "★★★"
        "entries" = @("la-008", "la-009")
    }
    "后现代享乐命令" = @{
        "aliases" = @("必须享乐", "淫荡客体")
        "related" = @("俄狄浦斯", "大对体的衰落")
        "difficulty" = "★★★"
        "entries" = @("la-009")
    }
}

if ($Help) {
    Write-Host @"
=============================
  齐泽克《斜目而视》分析范式知识库
=============================
  用法:
    .\query_kb.ps1 -Query "概念名"
    .\query_kb.ps1 -Chapter "章节名"
    .\query_kb.ps1 -ListConcepts
    .\query_kb.ps1 -Help

  额外资源:
    references/analytical-paradigms.md
      - 10个可迁移的分析范式
=============================
"@
    exit
}

if (-not (Test-Path $kbPath)) {
    Write-Error "知识库文件未找到: $kbPath"
    exit 1
}

$kb = Get-Content $kbPath -Raw -Encoding UTF8 | ConvertFrom-Json

if ($ListConcepts) {
    Write-Host "=== 分析范式与核心概念 ===" -ForegroundColor Cyan
    $conceptMap.Keys | Sort-Object | ForEach-Object {
        $c = $_; $info = $conceptMap[$c]
        Write-Host "[$($info.difficulty)] $c"
        if ($info.aliases.Count -gt 0) { Write-Host "     别名: $($info.aliases -join ', ')" }
        Write-Host "     条目: $($info.entries -join ', ')"
    }
    exit
}

if ($Chapter) {
    Write-Host "=== 章节检索: $Chapter ===" -ForegroundColor Cyan
    $results = $kb | Where-Object { $_.chapter -like "*$Chapter*" }
    $results | ForEach-Object { Write-Host "[$($_.id)] $($_.concepts -join ', ')" }
    Write-Host "共 $($results.Count) 条匹配"
    exit
}

if ($Query) {
    Write-Host "=== 关键词检索: $Query ===" -ForegroundColor Cyan
    $results = $kb | Where-Object {
        $_.text -like "*$Query*" -or ($_.concepts -join " ") -like "*$Query*"
    }
    if ($results.Count -eq 0 -and $conceptMap.ContainsKey($Query)) {
        Write-Host "概念存在于映射中，建议检索近义词: $($conceptMap[$Query].aliases -join ', ')"
    }
    $results | ForEach-Object { Write-Host "[$($_.id)] $($_.concepts -join ', ')" }
    Write-Host "共 $($results.Count) 条匹配"
    exit
}

Write-Host "=== 齐泽克《斜目而视》分析范式知识库 ===" -ForegroundColor Cyan
Write-Host "条目总数: $($kb.Count)"
Write-Host "核心概念: $($conceptMap.Count) 个"
Write-Host "分析范式: 10个（见 analytical-paradigms.md）"
