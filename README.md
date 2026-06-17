# 左翼理论星图 · Leftist Theory Star Map

基于 20 个结构化知识库的左翼理论综合分析系统，无缝集成 [opencode](https://opencode.ai) 的 Agent + Skill 架构。

## 系统架构

```
用户需求 → 感知层（层次识别）→ 三层次联动分析
                              ↕
              经济基础层 → 政治制度层 → 文化意识形态层
                              ↕
              20 个结构化知识库 + 跨框架辨析引擎
```

### 三层分析框架

| 层次 | 覆盖范围 |
|------|---------|
| **经济基础层** | 劳动价值论、剩余价值、资本积累、资本循环、地租、生息资本、历史唯物论 |
| **政治制度层** | 政治制度化、国家与法律、普力夺社会、政党理论 |
| **文化意识形态层** | 物化、文化霸权、文化工业、意识形态幻象、狗智主义、父权制、幽灵学 |

## 已包含的 Skill

### 核心组件（14 个）

| Skill | 来源 | 核心贡献 |
|-------|------|---------|
| `das-kapital-knowledge-base` | 马克思《资本论》第一卷 | 61 条目 + 5 深度分析 — 价值理论、剩余价值、资本积累 |
| `das-kapital-band-2` | 马克思《资本论》第二卷 | 59 条目 — 资本循环、周转、社会总资本再生产 |
| `das-kapital-band-3` | 马克思《资本论》第三卷 | 48 条目 — 平均利润、地租、生息资本、阶级 |
| `deutsche-ideologie` | 马克思、恩格斯《德意志意识形态》 | 20 条目 — 历史唯物论、意识形态批判、费尔巴哈批判 |
| `western-marxism` | 俞吾金、陈学明《西方马克思主义新编》 | 21 条目 — 物化、文化霸权、文化工业 |
| `capitalist-realism` | 马克·费舍《资本主义现实主义》 | 12 条目 — 资本主义现实主义、反身性无能 |
| `patriarchy-capitalism` | 上野千鹤子《父权制与资本主义》 | 55 条目 — 再生产劳动、父权制资本主义 |
| `derrida-spectres` | 德里达《马克思的幽灵》 | 20 条目 — 幽灵学、解构与马克思主义 |
| `zhaoliang-shijie` | 张一兵《照亮世界的马克思》 | 26 条目 — 齐泽克/哈维/奈格里对话 |
| `zizek-sublime-object` | 齐泽克《意识形态的崇高客体》 | 41 条目 — 意识形态幻象、狗智主义、征兆 |
| `zizek-looking-awry` | 齐泽克《斜目而视》 | 20 条目 + 10 分析范式 — 拉康式文化分析方法论 |
| `zizek-enjoy-symptom` | 齐泽克《享受你的症状！》 | 14 条目 — 行动作为实在界的回答 |
| `political-order-huntington` | 亨廷顿《变化社会中的政治秩序》 | 30 条目 — 政治制度化、普力夺社会、政党 |
| `pashukanis-legal-theory` | 帕舒卡尼斯《法的一般理论与马克思主义》 | 25 条目 — 法律拜物教、国家与法律形式 |

### 扩展组件（5 个）

| Skill | 来源 | 核心贡献 |
|-------|------|---------|
| `han-burnout-society` | 韩炳哲《倦怠社会》 | 38 条目 — 功绩社会、自我剥削、深度无聊 |
| `han-agony-of-eros` | 韩炳哲《爱欲之死》 | 35 条目 — 他者的消失、爱欲政治学 |
| `han-disappearance-of-other` | 韩炳哲《他者的消失》 | 45 条目 — 同质化的恐怖、倾听的伦理学 |
| `animalized-postmodern` | 东浩纪《动物化的后现代》 | 18 条目 — 数据库消费、御宅族文化、后现代主体 |
| `battle-maiden-psychoanalysis` | 斋藤环《战斗美少女的精神分析》 | 35 条目 — 菲勒斯少女、御宅精神病理 |

### 元 Skill（1 个）

| Skill | 说明 |
|-------|------|
| `leftist-theory-star-map` | 主 Skill：三层联动分析框架 + 跨框架辨析引擎 + 感知层 |

### 共享依赖（1 个）

| Skill | 说明 |
|-------|------|
| `close-reading-protocol` | 严谨阅读协议（所有深度分析的前置依赖） |

## 快速安装

```powershell
git clone https://github.com/Yuki-0079/leftist-theory-skills.git
cd leftist-theory-skills
powershell -ExecutionPolicy Bypass -File install.ps1
```

详细安装说明见 [INSTALL.md](INSTALL.md)。

## 快速使用

加载主 skill 后，你可以：

```text
"请以左翼理论分析师的身份工作，加载 leftist-theory 分析框架。"
"用三层框架分析这段文本。"
"从齐泽克的视角看这个现象。"
"综合资本论和上野千鹤子的理论分析这个问题。"
```

## 项目结构

```
leftist-theory-skills/
├── README.md              # 本文件
├── INSTALL.md             # 安装指南
├── install.ps1            # 一键安装脚本
├── .gitignore
├── skills/                # 20 个 skill + 1 个共享依赖
│   ├── leftist-theory-star-map/
│   ├── close-reading-protocol/
│   └── ...（其余 19 个）
└── agents/
    └── sfw/
        └── leftist-theory.md
```

## 许可

本项目中的知识库内容基于各原著的学术研究和整理，仅供学习和研究使用。各知识库引用的原著版权归原作者所有。
