# cheat-on-money —— AI 时代靠谱兼职发现 + 反诈验证 skill

帮你在 AI 时代找到**真能用**的兼职/副业。核心不是"列一堆项目"，而是四件别人不做的事：

1. **需求信号反推**，不搜"教你赚钱"的帖子（那是卖课钓粉的污染信源）——看行业报告/招聘/采购数据等利益中立信号，推理出个人能供给的机会，并用多个独立信号交叉验证
2. **实时检索 + 时效核查**，不靠模型记忆；来源超 24 个月默认失效（平台规则天天变）
3. **反诈 rubric**，每个机会过硬红线，宁可错杀
4. **个性化 + 可验证**，按你的画像匹配，每个机会都给"小成本先验证能不能收到第一笔钱"的路径

> 哲学同 cheat-on-content：可信度靠**机制**，不靠内容质量。

## 子 skill

| 命令 | 作用 |
|---|---|
| `money-init` | 首次：建画像（技能/时间/资金/地区/露脸）+ 状态文件 |
| `money-find` | 按画像实时检索机会 + 反诈筛选 |
| `money-verify` | **核心**：验证某个具体机会是不是骗局 |
| `money-plan` | 选定机会 → 行动方案 + 小成本验证第一步 |
| `money-retro` | 复盘实际投入/收入 vs 预期，沉淀经验 |
| `money-status` | 状态看板，任何时候可调 |

## 共享文档（机制所在）

- `shared-references/demand-signal-method.md` —— **需求信号反推法**（money-find 的主方法：信源分级 + 四步推理 + 交叉验证）
- `shared-references/anti-scam-rubric.md` —— 反诈判定标准 + C′ 时效核查（money-verify / money-find 的唯一标准来源）
- `shared-references/user-tiers.md` —— **用户段位 T0–T3**（按"资源×技能"分流，机会和收入预期都按段位给）
- `shared-references/opportunity-taxonomy.md` —— 机会分类框架（辅助分类，不是清单）
- `examples/worked-examples.md` —— 真实跑出来的高质量范本（给 money-find/money-verify 参照）
- `templates/money-state.template.json` —— 状态文件模板（schema v2，含 tier + 校准环字段）

## 数据 adapter（补一手数据短板）

都是 **B 档半自动**：用户自己登录+搜索（弹滑块手动过），adapter 只读当前页公开列表。绕开"通用网页检索进不去登录墙"的限制。

- `adapters/xianyu/` —— 闲鱼**成交侧**：一手"在卖什么/什么价/多少人想要"（"有人真付钱"的证据）。
- `adapters/boss/` —— BOSS直聘**招聘侧**：一手"在招什么/给多少/要哪些 AI 技能"（最诚实的需求温度计）。**只读搜索结果列表页**——列表卡片只有公开的岗位+薪资+公司，HR 个人信息在详情页/聊天里，adapter 一律不碰，故不触反诈红线 A6。两个 adapter 共享同一个 Chrome profile。

## 校准环（让它越用越准）

`money-plan` 写下「预期」（投入/见钱时间/收入）→ 执行 → `money-retro` 拿「实际」对账 → 经验回流到工作目录的 `lessons.md` → `money-find`/`money-verify` 下次开工先读它。预测→复盘→沉淀，闭环。

## 安装

### Claude Code

把各子 skill 软链到 `~/.claude/skills/`（与 cheat 系列一致）：

```bash
cd "$(dirname "$0")" 2>/dev/null
ROOT="$(pwd)"
for d in skills/*/; do
  name="$(basename "$d")"
  ln -sf "$ROOT/$d" "$HOME/.claude/skills/$name"
done
```

或直接运行 `./install.sh`。

### Codex

把各子 skill 安装到 `~/.codex/skills/`，同时给每个 skill 补上 Codex 友好的本地资源入口：

```bash
./install-codex.sh
```

安装后每个 Codex skill 目录会包含：

- `SKILL.md` → 对应子 skill
- `references/` → `shared-references/`
- `templates/` → 状态文件模板
- `examples/` → worked examples
- `adapters/` → 闲鱼 / BOSS 半自动 adapter

这样不会改动 Claude Code 的 `~/.claude/skills/` 安装方式；两套安装可以同时存在。Codex 读取 skill 列表通常需要重启应用或开启新会话。

> 说明：`SKILL.md` 里的 `allowed-tools` 是 Claude Code 权限声明。Codex 只依赖 `name` / `description` 触发 skill，会忽略这类 Claude 专属字段。

## 典型流程

```
"我想搞钱" → money-init（建画像）
"帮我找机会" → money-find（实时检索+反诈）
"XX 靠谱吗" → money-verify（验证）
"我做 XX，给我计划" → money-plan（行动方案+验证第一步）
执行一段时间 → money-retro（复盘）
随时 → money-status（看板）
```

## 重要声明

本工具提供的是**判断框架与实时检索辅助**，不构成投资/就业建议。最终决策与风险由用户自行承担。
凡涉及"先交钱、刷单、过账、出借账户"的，一律是骗局或违法，立刻远离。
