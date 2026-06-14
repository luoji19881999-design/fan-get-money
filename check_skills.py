for fname in [
    r"C:\Users\andy\Documents\fangetmoney\fan-money-plan\SKILL.md",
    r"C:\Users\andy\Documents\fangetmoney\fan-money-find\SKILL.md",
    r"C:\Users\andy\Documents\fangetmoney\fan-money-verify\SKILL.md",
    r"C:\Users\andy\Documents\fangetmoney\fan-money-retro\SKILL.md",
    r"C:\Users\andy\Documents\fangetmoney\fan-money-status\SKILL.md",
]:
    with open(fname, "rb") as f:
        raw = f.read()
    for enc in ["utf-8", "gbk", "gb18030"]:
        try:
            content = raw.decode(enc)
            has_trigger = "找找业务" in content or "要干" in content or "验证" in content or "复盘" in content or "进账状态" in content
            name = fname.split("\\")[-2]
            print(f"{name}: {enc} OK, trigger_ok={has_trigger}")
            break
        except:
            pass
