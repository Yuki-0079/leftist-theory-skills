param(
    [string]$Query = "",
    [string]$Layer = "",
    [switch]$ListComponents,
    [switch]$Help
)

$skillsDir = "$env:USERPROFILE\.config\opencode\skills"

# Core leftist components by layer
$layers = @{
    "经济基础" = @("das-kapital-knowledge-base","das-kapital-band-2","das-kapital-band-3","deutsche-ideologie")
    "政治制度" = @("political-order-huntington","pashukanis-legal-theory")
    "文化意识形态" = @("western-marxism","capitalist-realism","patriarchy-capitalism","derrida-spectres","zhaoliang-shijie","zizek-sublime-object","zizek-looking-awry","zizek-enjoy-symptom")
    "日本文化批判" = @("animalized-postmodern","battle-maiden-psychoanalysis")
    "韩炳哲" = @("han-burnout-society","han-agony-of-eros","han-disappearance-of-other")
}

if ($Help) {
    Write-Host @"
左翼理论星图跨库查询
  用法:
    .\query_all.ps1 -Query "概念名"        # 在所有组件中搜索
    .\query_all.ps1 -Layer "经济基础"      # 在指定层次中搜索
    .\query_all.ps1 -ListComponents        # 列出所有组件
    .\query_all.ps1 -Help                  # 帮助
"@
    exit
}

if ($ListComponents) {
    Write-Host "=== 左翼理论星图组件 ===" -ForegroundColor Cyan
    $total = 0
    foreach ($layer in $layers.Keys) {
        Write-Host "`n[$layer]" -ForegroundColor Yellow
        foreach ($s in $layers[$layer]) {
            $p = Join-Path $skillsDir $s
            $kbPath = Join-Path $p "references\knowledge-base.json"
            $count = "?"
            if (Test-Path $kbPath) {
                try {
                    $content = Get-Content $kbPath -Encoding UTF8 -Raw
                    $kb = $content | ConvertFrom-Json
                    if ($kb -is [array]) { $count = $kb.Count } else { $count = 1 }
                } catch {
                    $count = "err"
                }
            }
            $hasSkill = Test-Path (Join-Path $p "SKILL.md")
            $badge = if ($hasSkill) { "S" } else { " " }
            Write-Host ("  [{0}] {1} ({2}条)" -f $badge, $s, $count)
            if ($count -match '^\d+$') { $total += [int]$count }
        }
    }
    Write-Host "`n总计: $total 条知识条目" -ForegroundColor Green
    exit
}

if ($Layer) {
    if (-not $layers.ContainsKey($Layer)) {
        Write-Host "无效的层次: $Layer. 可选: $($layers.Keys -join ', ')"
        exit
    }
    $components = $layers[$Layer]
} else {
    $components = $layers.Values | ForEach-Object { $_ } | Sort-Object -Unique
}

foreach ($s in $components) {
    $p = Join-Path $skillsDir $s
    $kbPath = Join-Path $p "references\knowledge-base.json"
    if (-not (Test-Path $kbPath)) { continue }
    
    try {
        $kb = Get-Content $kbPath -Encoding UTF8 -Raw | ConvertFrom-Json
        if ($Query) {
            $results = $kb | Where-Object {
                $_.text -like "*$Query*" -or ($_.concepts -join " ") -like "*$Query*"
            }
            if ($results.Count -gt 0) {
                Write-Host "[$s] 找到 $($results.Count) 条" -ForegroundColor Yellow
                $results | ForEach-Object {
                    Write-Host "  [$($_.id)] $($_.concepts -join ', ')"
                }
            }
        }
    } catch {}
}

if (-not $Query -and -not $Layer) {
    Write-Host "左翼理论星图主skill - 14个组件，~452+条知识条目"
    Write-Host "使用 -Query 搜索, -Layer 按层次筛选, -ListComponents 列表"
}
