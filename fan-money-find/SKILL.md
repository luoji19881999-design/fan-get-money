---
name: fan-money-find
description: 按你的画像（技术+渠道+销售）实时搜需求信号，反推出你能做的一人公司方向，每个过反诈 rubric。触发词："找找业务"/"找业务"/"帮我找机会"/"找副业"。前置：需要 .money-state.json（无则先路由到 fan-money-init）。
argument-hint: "[可选方向]"
allowed-tools: Bash(*), Read, Write, Edit, Glob, WebSearch, WebFetch, Skill
---

# /fan-money-find — 找找业务：搜需求信号 + 反推一人公司方向

## 核心方法

严格遵循 `../shared-references/demand-signal-method.md`。

## 总流程

1. 先确认**"需求信号反推法"的前提**
2. 解读画像 + 对照分层
3. 多源实时搜索需求信号
4. 用 Data Adapter 读一手平台数据
5. 每个机会过反诈 rubric C' 关（24 分制）
6. 对所有结果诚实"降噪"
7. 参考 `../shared-references/anti-scam-rubric.md`
8. 用适当格式呈现给用户

## 步骤

### Step 0 — 前置
- `.money-state.json` 存在 + tier 已定，否则路由到 fan-money-init
- `../shared-references/user-tiers.md`
- `../shared-references/demand-signal-method.md`
- `../shared-references/opportunity-taxonomy.md`
- `../shared-references/anti-scam-rubric.md`
- `lessons.md`（如有）
- `../examples/worked-examples.md`

### Step 1 — 分层映射到搜索策略

根据 tier 决定搜索范围：T0→闲鱼/猪八戒；T1→电鸭/B站；T2→出海/GEO/SaaS；T3→综合。

**多源实时搜索**：

用 Chrome Extension / Playwright Adapter
- 闲鱼 -> `../adapters/xianyu`
- BOSS直聘 -> `../adapters/boss`（仅读公开招聘列表页）

用搜索引擎补充：
- site:zhipin.com "AI Agent" "兼职"
- site:goofish.com "AI服务"
- 其他[具体行业] 相关查询

搜索提示词框架：
- <行业> AI 赋能 兼职/远程
- <平台/工具> 视频号 B站
- 辅助爬取/填充 → 交叉

### Step 2 — 读 + 提炼
读每条搜到的信息，提炼成结构化机会卡片。

### Step 3 — 降噪 + 排序
按 anti-scam-rubric D 表输出每一条的判定（高危/存疑/可行），T0 阶段尤其重要。

### Step 4 — 呈现 + 导出
用 机会名→来源→判定→收入预期→第一步 的格式呈现，并引导至 fan-money-plan / fan-money-verify。

所有结果向用户明确标注信息截止日期。
