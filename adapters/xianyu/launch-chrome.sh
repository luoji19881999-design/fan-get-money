#!/usr/bin/env bash
# 用「带远程调试端口 + 独立 profile」的方式启动 Chrome。
# 第一次会让你登录闲鱼(扫码),登录态存在独立 profile 里,以后不用重登。
# 这个 Chrome 是你自己在操作:你来搜索、你来过滑块 —— adapter 只读当前页。
set -euo pipefail
PORT="${1:-9222}"
PROFILE="$HOME/.money-chrome-profile"
CHROME="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
mkdir -p "$PROFILE"
echo "启动 Chrome(调试端口 $PORT, profile=$PROFILE)"
echo "→ 在打开的窗口里【扫码登录闲鱼】(必须登录,否则看不到结果),保持窗口开着"
echo "→ 然后回来运行: node read-xianyu.mjs \"AI头像\" $PORT"
exec "$CHROME" --remote-debugging-port="$PORT" --user-data-dir="$PROFILE" "https://www.goofish.com"
