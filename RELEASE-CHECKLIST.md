# cheat-on-money skill 发布前 Checklist

状态图例:✅ 已完成 · ⏳ 待你把关 · 🔜 二期可选

## A. 核心机制(必须)
- ✅ 反诈 rubric(6 条硬红线 + 存疑 + 实时查证)
- ✅ 时效核查 C′(>24 月失效、关键数字下钻一手)
- ✅ 需求信号反推法(信源分级 + 四步 + 交叉验证)
- ✅ 用户段位 T0–T3 分流(机会与收入预期按段位给)
- ✅ 校准闭环(plan 写预期 → retro 对账 → lessons.md → find/verify 读)

## B. 端到端验证
- ✅ 结构 dry-run:文件/路径/JSON/字段接线全通过
- ✅ T0 用户全链跑通:init→find→verify→plan→retro→status(模拟,/tmp/money-test-t0)
- ✅ 闲鱼 adapter 真机验证:Claude 起浏览器 + 用户扫码 + 读到一手成交数据(并现场修 2 bug)
- ⏳ **真人(非模拟)冷启动跑一遍**:你以真实用户身份从 money-init 走完整流程,确认话术/体验
- ⏳ **闲鱼 adapter 选择器在更多关键词上复测**(现仅在"AI头像"校准过)

## C. 安全/合规(必须)
- ✅ 法律红线写进反诈(A4 过账/A6 灰产 → 劝退 + 提示违法)
- ✅ adapter 风险标注(read-only/低频/BOSS 不自动化/个人信息红线)
- ⏳ **money-init 首屏加免责声明**(不构成投资/就业建议)——目前在 README,建议也前置到 init
- ⏳ 决定 adapter 是否随 skill 公开分发(爬取 ToS 风险;或仅作可选组件)

## D. 已知边界(发布说明里如实写)
- WebSearch 是境外节点,中国本土实时数据靠 adapter 或手动贴
- adapter 选择器会随平台改版腐烂,需偶尔维护
- aihot 雷达偏国际,中国垂直需求覆盖弱

## E. 二期可选(发布后迭代)
- 🔜 money-verify 盲验证 sub-agent(抗确认偏误)
- 🔜 money-find 快/深双模(控 token 与延迟)
- 🔜 BOSS 手动贴 JD 的解析话术
- 🔜 国内搜索/数据 MCP 接入

## 发布判断
- **可灰度**:完成 B 的两个 ⏳ + C 的免责声明 → 可发给一小群目标用户。
- **可公开**:灰度收集真实 retro 数据、修掉暴露的问题后再扩大。
