---
name: fan-money-status
description: fan-get-money skill 的状态看板。显示用户画像、候选机会及其反诈判定、当前在执行的机会与进度、复盘记录、建议的下一步。无副作用，任何时候可调。触发词："搞钱状态"/"我现在的进度"/"看板"/"money status"/"我现在该做什么"。
argument-hint: ""
allowed-tools: Bash(*), Read, Glob, Skill
---

# /fan-money-status — 状态总览看板

只读操作，无副作用。

## 步骤

### Step 1 — 状态检查
```bash
test -f .money-state.json && echo OK || echo MISSING
```
- MISSING -> 路由到 fan-money-init
- OK -> 继续读取

### Step 2 — 读取
- 画像 + 分层 T0-T3 + 分层理由
- lessons.md 经验教训
- 活跃机会/当前进度/收入/预测对比
- 候选机会 + 反诈判定结果
- 查看 archive/ 复盘历史

### Step 3 — 建议下一步
- 无活跃 → fan-money-find
- 有候选 → fan-money-verify
- 已验证 → fan-money-plan
- 执行中 → fan-money-retro

结果逐节呈现，标注信息更新时间。
