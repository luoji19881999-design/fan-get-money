import os, glob

base = r"C:\Users\andy\Documents\fangetmoney"
skills = glob.glob(os.path.join(base, "fan-money-*", "SKILL.md"))

for fpath in skills:
    with open(fpath, "rb") as f:
        raw = f.read()
    
    # Detect and decode
    content = None
    for enc in ["utf-8-sig", "utf-8", "gbk", "gb18030"]:
        try:
            content = raw.decode(enc)
            break
        except:
            continue
    
    if content is None:
        print(f"FAILED: {fpath}")
        continue
    
    # Write as UTF-8
    with open(fpath, "w", encoding="utf-8") as f:
        f.write(content)
    
    name = os.path.basename(os.path.dirname(fpath))
    print(f"OK: {name} -> UTF-8")

print("\nDone. All SKILL.md converted to UTF-8.")
