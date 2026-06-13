---
name: fan-money-plan
description: 为用户选定的某个「可行」机会生成可执行行动方案：小成本验证第一步、前两周具体动作、诚实收入预期、止损线。触发词："我想做XX帮我做计划"/"这个怎么开始"/"给我行动方案"/"money plan"/"我选这个"。前置：该机会最好已过 fan-money-verify 判定为可行/存疑。
argument-hint: "<选定的机会>"
allowed-tools: Bash(*), Read, Write, Edit, Glob, WebSearch, WebFetch, Skill
---

# /fan-money-plan — 行动计划生成 + 预测备案

## 前置
- 读 `.money-state.json` 确认画像和所选机会，机会最好已过 `fan-money-verify`
- 读用户画像的 tier、技能、时间约束，行动计划必须匹配这些

## 计划 5 模块

1. **第一步小成本验证**：最低成本最快拿到信号的方式
2. **前两周动作**：按天/周拆解的具体任务清单
3. **收入预期**：诚实预测前 3 个月的收入范围和达成概率
4. **止损线**：如果 X 天没有达到 → 转向备选 → 复盘
5. **AI 加持**：AI 在每个环节可以提效的具体用法

## 备案写入

写入 `.money-state.json` 的 `active` 字段：chosen_id / started_at / plan 摘要及 chosen。
写入 `active.prediction` 字段：预测耗时/首次收入天数/收入范围，recorded_at=当前日期。
**主动说明**：这些预测会在 fan-money-retro 里被复盘。

## 后续
路由到 fan-money-status 看后续状态，T+N 天用 fan-money-retro 复盘并决定是否调整。
