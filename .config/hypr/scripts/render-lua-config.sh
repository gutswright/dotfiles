#!/usr/bin/env sh
set -eu

cd "$(dirname "$0")/.."

if command -v lua >/dev/null 2>&1; then
  exec lua scripts/render-lua-config.lua
elif command -v luajit >/dev/null 2>&1; then
  exec luajit scripts/render-lua-config.lua
elif command -v nvim >/dev/null 2>&1; then
  exec env NVIM_LOG_FILE=/tmp/hypr-render-nvim.log nvim -u NONE -i NONE --headless -l scripts/render-lua-config.lua
else
  printf '%s\n' 'No Lua runtime found. Install lua, luajit, or nvim.' >&2
  exit 1
fi
