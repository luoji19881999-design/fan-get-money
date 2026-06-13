---
name: fan-money-init
description: fan-get-money skill 的首次 onboarding。建立用户画像（技能/可投入时间/启动资金/地区/能否露脸/语言）并创建 .money-state.json 状态文件，是所有其他 fan-money-* skill 的前置。触发词："搞钱初始化"/"我想搞钱"/"找AI兼职"/"money init"/"搞钱 setup"。**当用户想找搞钱机会但 .money-state.json 不存在时，先路由到此。**
argument-hint: ""
allowed-tools: Bash(*), Read, Write, Edit, Glob, Skill
---

# /fan-money-init — fan-get-money 首次 onboarding

只问"必要的"而非"全面调查问卷"。<= 5 个问题。

## 资源引用

本 repo 使用根目录 `shared-references/` / `templates/` / `adapters/` / `examples/` 存放共享文件。安装脚本会将它们复制到每个 skill 目录，使每个 skill 独立可用。

## 核心原则

不问"兴趣爱好"类无用信息，只收集**技能 + 时间 + 启动资金 + 地区 + 能否露脸**。init 后等于帮用户完成"知己 = 知彼"，后续 skill 负责"知彼"。

## Overview

```
[用户说"想搞钱"]
  ↓
[Phase 0: 检查 .money-state.json 是否存在]
  ↓
[Phase 1: 收集必要信息 + 画像]
  ↓
[Phase 2: 10 维度画像评估与打分]
  ↓
[Phase 3: 分层定级 + 写入 .money-state.json]
  ↓
[Phase 4: 给"下一步"指引]
```

## Phase 0 — 状态检查

```bash
test -f .money-state.json && echo EXISTS || echo MISSING
```
- 已存在则读出并显示摘要，提示可用 `fan-money-status`
- 不存在则继续

## Phase 1 — 信息收集

- 先说明"我只问必要的，大约 5 个问题"，降低用户防御
- 收集维度：技能清单 / 每日可用时间 / 启动资金 / 所在地区 / 是否可露脸 / 语言
- 用"追问而非推销"的方式收集

## Phase 2 — 10 维度评估

按 10 个维度给用户打分并解释：

1. **技能广度**
2. **人脉**
3. **行业/平台经验**（是否做过小红书/闲鱼/B站/抖音等）
4. **工具熟练度**（Cursor/Claude Code/Codex/PS/剪映/PR/Canva/Figma/Excel/Python/前端）
5. **时间弹性与持续性**
6. **启动资金**（从 0 到有多少可投入）
7. **可接单灵活性 / 能否露脸**
8. **出海 / 多语能力**
9. **风险 / 沉没成本承受力**
10. **信息判断力**（是否能识别卖课/割韭菜/用虚假截图宣传）

> 每个维度有 null 就正常说明，不打虚假高分。

## Phase 3 — 分层 + 写入

对照 `../shared-references/user-tiers.md` 按"技能 x 时间 x 资金"判定 T0/T1/T2/T3 层级。

分层参考：
- 零技能+零资金+零经验 → T0
- 有 AI 工具熟练度（Cursor/Claude Code/Codex）+ 丰富行业经验 → T2
- 单一 AI 技能/内容 → T1
- 团队/资本/出海/技术复合 → T3
- 第7条"能否露脸" → 影响内容类机会

> 如果用户此前已有 `.money-state.json`，不覆盖旧的，只是追加更新，由 fan-money-retro 负责版本管理。

对照 `../templates/money-state.template.json` 填入数据，设置 `updated_at` 为当前日期，写入 `.money-state.json`。重要：不需要 `age`/`gender`/`past_experience`/`team_size` 字段。

## Phase 4 — 下一步指引

给用户 5 个下一步选项：

- **`搞钱状态`** — 查看画像摘要，用 fan-money-status
- **`帮我找机会`** — 基于你的画像去实时搜索和推理具体机会，用 fan-money-find
- **`做 XX 的计划`** — 为某个 AI 机会 + 你生成行动方案，用 fan-money-plan
- **`查 XX`** — 用反诈 rubric 验证某个具体项目/兼职/帖子是否可靠，用 fan-money-verify
- **`复盘 XX`** — 复盘一个你正在做或做过的 AI 机会，沉淀到 lessons.md，用 fan-money-retro
- **`搞钱状态`** — 查看当前进度看板，用 fan-money-status
