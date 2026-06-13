# fan-get-money

**AI 时代搞钱助手** — 适配主流 Vibe Coding 平台的搞钱技能包，用「需求信号反推法」帮你找 AI 时代的兼职/副业/搞钱机会，并配套反诈验证、行动计划、复盘的完整闭环。

> 不搜"教你赚钱"的帖子（那是卖课钓粉的污染信源）。从行业报告、招聘数据、一手平台成交数据里反推出真正的需求信号，推理个人能供给的机会。

## 它能做什么

| 阶段 | 命令 | 做了什么 |
|------|------|----------|
| [Init] 初始化 | `/fan-money-init` | 10 个问题建立你的画像，10 维度评估，分 T0-T3 层级 |
| [Find] 找机会 | `/fan-money-find` | 实时搜索 + 一手平台数据，需求信号反推法输出机会列表 |
| [Verify] 反诈 | `/fan-money-verify` | 对任意项目过反诈 rubric 24 分制，高危直接毙 |
| [Plan] 行动 | `/fan-money-plan` | 生成执行计划：第一步验证、两周动作、预期收入、止损线 |
| [Retro] 复盘 | `/fan-money-retro` | 对比预测 vs 实际，沉淀 lessons.md，触发层级升级 |
| [Status] 看板 | `/fan-money-status` | 只读状态总览：画像、机会、进度、复盘记录 |

## 适用平台 & 工具

`fan-get-money` 是一个**方法技能包**，不是某个平台的专属插件。支持以下所有 Vibe Coding 平台和 AI 编程工具：

| 平台 | 类型 | 安装方式 | 触发方式 |
|------|------|----------|----------|
| **[OpenAI Codex](https://openai.com/codex)** | AI 编码助手 | `./install-all.sh codex` 或 `./install-codex.sh` | `/fan-money-init` |
| **[Anthropic Claude Code](https://claude.ai)** | AI 编码助手 (CLI) | `./install-all.sh claude` | "搞钱初始化" |
| **[Cursor](https://cursor.com)** | AI IDE | `./install-all.sh cursor` | Rules 自动生效 |
| **[Google Gemini CLI](https://github.com/google-gemini)** | AI 编码助手 (CLI) | `./install-all.sh gemini` | "搞钱初始化" |
| **[GitHub Copilot](https://github.com/features/copilot)** | AI 编码助手 | `./install-all.sh copilot` | Instructions 自动生效 |
| **[Windsurf](https://codeium.com/windsurf)** | AI IDE | `./install-all.sh windsurf` | Rules 自动生效 |
| **[Hermes](https://hermes.ai)** | AI 编码助手 | `./install-all.sh hermes` | "搞钱初始化" |
| **[WordBuddy](https://wordbuddy.com)** | AI 写作/编码工具 | `./install-all.sh wordbuddy` | "搞钱初始化" |

> 如果不属于以上平台，也可以直接用：把 `platforms/universal/INSTRUCTIONS.md` 的内容粘贴到任意 AI 工具的 **Custom Instructions / System Prompt / Rules** 字段即可生效。适配器脚本（闲鱼 / BOSS 直聘数据抓取）在 `adapters/` 目录下独立运行，不依赖任何平台。

### 在各平台的体验差异

| 功能 | Codex | Claude Code | Cursor | Gemini | Copilot | Windsurf | Hermes | WordBuddy |
|------|:-----:|:-----------:|:------:|:------:|:-------:|:--------:|:------:|:---------:|
| 命令触发 | `/fan-money-init` | 自然语言 | Rules 自动 | 自然语言 | 自动 | 自动 | 自然语言 | 自然语言 |
| .money-state.json | 全自动 | 全自动 | 全自动 | 全自动 | 全自动 | 全自动 | 全自动 | 全自动 |
| 实时 WebSearch | 内置 | 内置 | 内置 | 内置 | 内置 | 内置 | 需配置 | 需配置 |
| 运行适配器 | 可运行 | 可运行 | 可运行 | 可运行 | 可运行 | 可运行 | 可运行 | 可运行 |
| 五层反诈 | 完整 | 完整 | 完整 | 完整 | 完整 | 完整 | 完整 | 完整 |
| lessons.md 沉淀 | 支持 | 支持 | 支持 | 支持 | 支持 | 支持 | 支持 | 支持 |

## 工作原理

### 需求信号反推法

传统做法是搜"怎么赚钱"→ 得到卖课的。我们用四个独立信源交叉验证：

1. **招聘数据**（一手）：Boss直聘/电鸭在招什么 AI 岗，什么词在涨 → 有人在花钱买这个能力
2. **成交数据**（一手）：闲鱼上"AI 相关"在卖什么、什么价、多少人想要 → 真实市场供需
3. **客户采购数据**（二手）：企查查/招标网中小企业在采购什么 AI 服务
4. **行业报告**（背景验证）：券商研报、政府报告中的增速和预算数据

四类信号交叉 → 推理出个人能供给的机会 → 再过反诈 rubric。

### 反诈 Rubric（五层递进）

- **A 类**：发现信号（先交钱、兜售"稳赚"、模糊词等 6 条）
- **B 类**：验证信号（强制转微信/QQ、阅读量造假等 6 条）
- **C 类**：推理分析（搜负面、搜受害者记录、搜真实收款等 4 步）
- **C' 类**：24 分量化评分
- **C" 类**：关键词黑名单（命中 2 条直接高危）

## 安装

### 前提

- [Codex](https://openai.com/codex) 已安装
- Node.js 22+（仅 xianyu adapter 需要 `npm install`；boss adapter 零依赖）

### 一键安装

**macOS / Linux:**
```bash
git clone https://github.com/fan19881999/fan-get-money.git
cd fan-get-money
chmod +x install-codex.sh
./install-codex.sh
```

**Windows (PowerShell):**
```powershell
git clone https://github.com/fan19881999/fan-get-money.git
cd fan-get-money
.\install-codex.ps1
```

安装脚本将每个 skill 复制到 `$CODEX_HOME/skills/`（默认 `~/.codex/skills/`），并自动附带 shared-references、templates、examples、adapters。

### 安装后

启动 Codex，直接说 `/fan-money-init` 开始。

## 技能详情

### fan-money-init
首次 onboarding。只问 10个必要问题（技能、时间、资金、地区、能否露脸），10 维度评估，判定 T0-T3 层级，生成 `.money-state.json`。所有后续 skill 的前置。

### fan-money-find
核心找机会技能。根据你的 tier 自动选择搜索策略。使用适配器读取闲鱼和 BOSS 直聘的一手数据，结合 WebSearch 交叉验证，每个机会标注来源 + 时效 + 收入预期。

### fan-money-verify
反诈核心。支持验证链接、项目名、帖子。五层 rubric 递进：信号检测 → 信号验证 → 负面查证 → 24 分量化 → 关键词黑名单。输出"可行/存疑/高危"判定。

### fan-money-plan
为你选定的可行机会生成可执行计划：最低成本第一步、前两周天级动作、诚实收入预期、明确止损线。

### fan-money-retro
复盘执行中的机会。对比预测 vs 实际，自动判断 tier 升级条件（如 T0→T1 需至少 1 条 AI 工具经验 + 收入转化），沉淀到 `lessons.md` 和 `archive/`。

### fan-money-status
无副作用的只读看板。查看画像、候选机会判定、当前进度、复盘历史、下一步建议。

## 适配器（Data Adapters）

仓库自带两个浏览器数据适配器，用于读取一手平台数据。均为**半自动、只读、human-in-the-loop**设计 —— 不自动登录、不批量爬取、不碰个人信息。

### 闲鱼适配器

```bash
cd adapters/xianyu
npm install                    # 仅需 playwright-core
./launch-chrome.sh             # 或 Windows: .\launch-chrome.ps1
# → 在弹出的 Chrome 里扫码登录闲鱼
node read-xianyu.mjs "AI头像" 9222
# → 输出当前搜索结果的 JSON
```

### BOSS 直聘适配器

```bash
cd adapters/boss
# 零依赖，无需 npm install
./launch-chrome.sh             # 或 Windows: .\launch-chrome.ps1
# → 在弹出的 Chrome 里扫码登录 BOSS 直聘
node read-boss.mjs "AIGC" 100010000 9222
# → 输出当前搜索结果的 JSON
```

> [Init] 两个 adapter 都是 **B 档（human-in-the-loop, read-only）**：只读公开列表页、低频使用、不碰个人隐私、不规避平台审核。**请勿改成自动批量爬取**（触发风控 + 违反 ToS + 违反反诈 rubric A6）。

## 仓库结构

```
fan-get-money/
├── README.md
├── .gitignore
├── install-codex.sh          # Codex 安装脚本 (macOS/Linux)
├── install-codex.ps1         # Codex 安装脚本 (Windows)
├── install-all.sh            # 多平台安装脚本 (macOS/Linux)
├── install-all.ps1           # 多平台安装脚本 (Windows)
├── platforms/                # 各平台适配文件
│   ├── universal/INSTRUCTIONS.md  # 通用指令（可粘贴到任意 AI 工具）
│   ├── claude-code/CLAUDE.md
│   ├── cursor/fan-get-money.mdc
│   ├── gemini/instructions.md
│   ├── copilot/copilot-instructions.md
│   ├── hermes/HERMES.md
│   └── wordbuddy/WORDBUDDY.md
├── shared-references/        # 所有 skill 共享的参考文档
│   ├── user-tiers.md         # T0-T3 分层标准 + 升级条件
│   ├── demand-signal-method.md  # 需求信号反推法详解
│   ├── anti-scam-rubric.md   # 五层反诈 rubric
│   └── opportunity-taxonomy.md  # AI 时代机会分类框架
├── templates/
│   └── money-state.template.json  # .money-state.json 模板
├── examples/
│   └── worked-examples.md    # 6 个真实跑出来的优质案例
├── adapters/
│   ├── boss/                 # BOSS 直聘适配器（零依赖 CDP）
│   │   ├── read-boss.mjs
│   │   ├── launch-chrome.sh
│   │   ├── launch-chrome.ps1
│   │   └── README.md
│   └── xianyu/               # 闲鱼适配器（需 playwright-core）
│       ├── read-xianyu.mjs
│       ├── launch-chrome.sh
│       ├── launch-chrome.ps1
│       └── README.md
├── fan-money-init/
│   └── SKILL.md
├── fan-money-find/
│   └── SKILL.md
├── fan-money-verify/
│   └── SKILL.md
├── fan-money-plan/
│   └── SKILL.md
├── fan-money-retro/
│   └── SKILL.md
└── fan-money-status/
    └── SKILL.md
```

## 数据文件

### .money-state.json
用户状态文件，存储在 workspace 根目录。安装后首次运行 `fan-money-init` 自动生成。

```json
{
  "schema_version": 2,
  "updated_at": "2026-06-13",
  "profile": {
    "tier": "T0",
    "skills": ["写作", "AI绘图"],
    "daily_hours": 2,
    "startup_capital": 0,
    "region": "中国大陆",
    "can_show_face": true,
    "language": ["中文", "英文"]
  },
  "active": {
    "chosen_id": null,
    "prediction": {}
  }
}
```

### lessons.md
经验和教训的累积文件，由 `fan-money-retro` 自动写入。

### archive/
每次复盘生成一个 JSON 归档文件，记录预测 vs 实际的完整对比。

## 设计哲学

1. **需求信号 > 推销文案**：不看"教你赚钱"的内容，只看有人在花钱买什么
2. **一手数据 > 二手报告**：adapter 读真实成交价 + 真实招聘需求
3. **反诈第一**：任何机会先过 rubric，再谈其他
4. **诚实收入预期**：不画饼，标注"前 3 个月通常无收入"等现实信息
5. **human-in-the-loop**：浏览器操作（登录、过验证码）必须真人做，只读结果
6. **分层升级**：T0→T1→T2，能力不到不推荐高门槛机会

## 许可

MIT License

## 贡献

欢迎提 Issue 和 PR。

- 适配器坏了（平台改版导致选择器失效）→ 发 `diagnostics` 输出即可，几分钟能校准
- 有新的平台适配器 → 按照 `human-in-the-loop, read-only` 规范写，过反诈 self-check
- 有新的机会分类 → 更新 `opportunity-taxonomy.md`
## 重要声明
本工具提供框架和辅助，不构成投资/就业建议和判断。最终决策与风险由用户自己承担。合法合规创业和工作远离诈骗和资金盘






