---
name: fan-money-status
description: 随时看全局：画像、机会列表、当前进度、复盘记录。无副作用，任何时候可调。触发词："进账状态"/"搞钱状态"/"我现在的进度"/"看板"/"我现在该做什么"。
argument-hint: ""
allowed-tools: Bash(*), Read, Glob, Skill
---

# /fan-money-status — 进账状态：全局看板

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
