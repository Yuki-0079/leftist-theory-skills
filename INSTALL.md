# 安装指南

## 前置条件

- **opencode**：已安装并可用
- **PowerShell 5.1+**：Windows 系统自带

## 自动安装（推荐）

```powershell
git clone https://github.com/YOUR_USERNAME/leftist-theory-skills.git
cd leftist-theory-skills
powershell -ExecutionPolicy Bypass -File install.ps1
```

参数说明：
- `-Force`：覆盖已安装的 skill（不指定则跳过已存在项）

## 手动安装

### 1. 安装 Skill

```powershell
$target = "$env:USERPROFILE\.config\opencode\skills"
Copy-Item -Path "skills\*" -Destination $target -Recurse
```

### 2. 安装 Leftist Theory Agent

```powershell
$agentTarget = "$env:USERPROFILE\.config\opencode\agents\sfw"
New-Item -ItemType Directory -Path $agentTarget -Force
Copy-Item -Path "agents\sfw\leftist-theory.md" -Destination $agentTarget -Force
```

## 验证安装

```powershell
# 检查 skill 数量
$installed = Get-ChildItem "$env:USERPROFILE\.config\opencode\skills" -Directory
Write-Output "已安装 $($installed.Count) 个 skill"

# 检查左翼理论特定 skill
$required = @("leftist-theory-star-map","das-kapital-knowledge-base","capitalist-realism","zizek-sublime-object")
foreach ($s in $required) {
    $found = Test-Path "$env:USERPROFILE\.config\opencode\skills\$s"
    Write-Output "  $s : $(if($found){'✓'}else{'✗'})"
}

# 检查 Agent
Test-Path "$env:USERPROFILE\.config\opencode\agents\sfw\leftist-theory.md"
```

## 卸载

```powershell
# 删除所有左翼理论 skill
$skills = Get-Content "uninstall_manifest.txt"
foreach ($item in $skills) {
    Remove-Item -Path $item -Recurse -Force -ErrorAction SilentlyContinue
}
```

或逐个删除：

```powershell
$skills = @("leftist-theory-star-map","close-reading-protocol","das-kapital-knowledge-base",
            "das-kapital-band-2","das-kapital-band-3","deutsche-ideologie",
            "western-marxism","capitalist-realism","patriarchy-capitalism",
            "derrida-spectres","zhaoliang-shijie","zizek-sublime-object",
            "zizek-looking-awry","zizek-enjoy-symptom","political-order-huntington",
            "pashukanis-legal-theory","han-burnout-society","han-agony-of-eros",
            "han-disappearance-of-other","animalized-postmodern","battle-maiden-psychoanalysis")
foreach ($s in $skills) {
    Remove-Item "$env:USERPROFILE\.config\opencode\skills\$s" -Recurse -Force -ErrorAction SilentlyContinue
}
Remove-Item "$env:USERPROFILE\.config\opencode\agents\sfw\leftist-theory.md" -Force -ErrorAction SilentlyContinue
```

## 常见问题

**Q：install.ps1 提示权限错误？**
A：以管理员身份运行 PowerShell，或使用 `-ExecutionPolicy Bypass` 参数。

**Q：已有同名的 skill 会怎样？**
A：默认跳过（不覆盖），使用 `-Force` 参数强制覆盖。

**Q：和 writing-sfw 共用 close-reading-protocol 会冲突吗？**
A：不会。两个项目各自包含完整的 close-reading-protocol，安装时如果已存在会跳过，内容完全一致。
