<#
.SYNOPSIS
    左翼理论星图 — 一键安装脚本
.DESCRIPTION
    将 skills/ 和 agents/ 安装到 opencode 配置目录。
.PARAMETER Force
    覆盖已存在的 skill（默认跳过）
.EXAMPLE
    .\install.ps1
    .\install.ps1 -Force
#>

param(
    [switch]$Force
)

$ErrorActionPreference = "Stop"
$repoRoot = Split-Path -Parent $MyInvocation.MyCommand.Path

# 目标路径
$skillTarget = "$env:USERPROFILE\.config\opencode\skills"
$agentTarget = "$env:USERPROFILE\.config\opencode\agents\sfw"

# 统计
$installed = @(); $skipped = @(); $failed = @()

Write-Host "=== 左翼理论星图 安装脚本 ===" -ForegroundColor Cyan
Write-Host ""

# ---- Step 1: 安装 Skills ----
Write-Host "[Step 1/2] 安装 Skills → $skillTarget" -ForegroundColor Yellow
New-Item -ItemType Directory -Path $skillTarget -Force | Out-Null

$skillDirs = Get-ChildItem (Join-Path $repoRoot "skills") -Directory
foreach ($dir in $skillDirs) {
    $dest = Join-Path $skillTarget $dir.Name
    if (Test-Path $dest) {
        if ($Force) {
            Remove-Item -Path $dest -Recurse -Force
            Copy-Item -Path $dir.FullName -Destination $dest -Recurse -Force
            $installed += $dir.Name
            Write-Host "  [覆盖] $($dir.Name)" -ForegroundColor Green
        } else {
            $skipped += $dir.Name
            Write-Host "  [跳过] $($dir.Name)（已存在）" -ForegroundColor DarkYellow
        }
    } else {
        Copy-Item -Path $dir.FullName -Destination $dest -Recurse -Force
        $installed += $dir.Name
        Write-Host "  [安装] $($dir.Name)" -ForegroundColor Green
    }
}

# ---- Step 2: 安装 Leftist Theory Agent ----
Write-Host "`n[Step 2/2] 安装 Leftist Theory Agent → $agentTarget" -ForegroundColor Yellow
New-Item -ItemType Directory -Path $agentTarget -Force | Out-Null

$agentSrc = Join-Path $repoRoot "agents\sfw\leftist-theory.md"
$agentDest = Join-Path $agentTarget "leftist-theory.md"

if (Test-Path $agentDest -and -not $Force) {
    $skipped += "leftist-theory.md"
    Write-Host "  [跳过] leftist-theory.md（已存在）" -ForegroundColor DarkYellow
} else {
    Copy-Item -Path $agentSrc -Destination $agentDest -Force
    $installed += "leftist-theory.md"
    Write-Host "  [安装] leftist-theory.md" -ForegroundColor Green
}

# ---- 完成摘要 ----
Write-Host ""
Write-Host "=== 安装完成 ===" -ForegroundColor Cyan
Write-Host "  Skills 安装: $(($installed | Where-Object { $_ -ne 'leftist-theory.md' }).Count) 个" -ForegroundColor Green
Write-Host "  Skills 跳过: $(($skipped | Where-Object { $_ -ne 'leftist-theory.md' }).Count) 个" -ForegroundColor DarkYellow
Write-Host "  Agent: $(if ($installed -contains 'leftist-theory.md') { '已安装' } else { '已跳过' })" -ForegroundColor Cyan
Write-Host ""

# 生成卸载清单
$manifestPath = Join-Path $repoRoot "uninstall_manifest.txt"
$skillNames = $skillDirs | ForEach-Object { $_.Name }
$manifestLines = @(
    "# 左翼理论星图 — 卸载清单"
    "# 由 install.ps1 生成于 $(Get-Date -Format "yyyy-MM-dd HH:mm:ss")"
    "# 删除以下文件/目录即可卸载"
)
foreach ($sn in $skillNames) {
    $manifestLines += "$skillTarget\$sn"
}
$manifestLines += "$agentTarget\leftist-theory.md"

$manifestLines -join "`r`n" | Out-File -FilePath $manifestPath -Encoding utf8

Write-Host "提示：" -ForegroundColor Cyan
Write-Host "  1. 在 opencode 中使用时，加载 leftist-theory Agent："
Write-Host "     '请以左翼理论分析师的身份工作，加载 leftist-theory 分析框架。'"
Write-Host "  2. 取消安装请运行：Get-Content uninstall_manifest.txt | ForEach-Object { Remove-Item -Path $_ -Recurse -Force }"
Write-Host "  3. 卸载清单已保存至：$manifestPath"
