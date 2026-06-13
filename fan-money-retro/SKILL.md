---
name: fan-money-retro
description: 复盘某个正在执行的搞钱机会：记录实际投入时间/实际收入 vs 当初预期，沉淀经验（哪类机会对我有效、哪些坑亲历过），更新状态文件。触发词："复盘"/"这个搞得怎么样"/"实际赚了多少"/"money retro"/"总结一下"。
argument-hint: "<机会名称>"
allowed-tools: Bash(*), Read, Write, Edit, Glob, Skill
---

# /fan-money-retro — 复盘 + 学习沉淀 + 升级

## 步骤

### Step 1 — 读取预测
读 `.money-state.json` 的 `active.prediction`。

### Step 2 — 收集实际
- 实际投入了多少时间
- 实际赚了多少
- 过程遇到了哪些问题
- 哪些认知被验证/推翻

### Step 3 — 预测 vs 实际
逐一对比预期时间 / 收入 / 难度。

### Step 3.5 — 嵌套升级判断

对照 `../shared-references/user-tiers.md` 判断。

**T0 -> T1**：lessons.md 中至少沉淀 1 条 AI 工具使用经验且有收入转化，tier 升为 T1。

**T1 -> T2**：熟练掌握 Cursor/Claude Code/Codex 并在实际接单中使用，tier 升为 T2。

升级后提示用户触发 fan-money-find 重新搜更高层机会。

### Step 4 — 归档 + 写入 + 给建议

- **归档**：完整复盘 JSON 写入 `archive/<id>_<date>.json`，JSON 包含预测/实际/教训。
- 更新 .money-state.json 的 status。
- **更新 lessons.md**：追加"经验"与"教训"部分。
- 如满足条件更新 profile.tier。

## 后续
- 成功 → 可继续
- 失败 → 推荐用 fan-money-find 重新找
- 一切正常 → 展示下一步行动建议
