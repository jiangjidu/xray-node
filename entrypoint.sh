#!/bin/sh
# 入口：用环境变量渲染 xray 配置后启动。
# 必需：UUID；可选：WS_PATH（默认 /proxy）、PORT（默认 3000，PaaS 注入 $PORT 时自动适配）。
set -e

: "${UUID:?UUID env var is required}"
export PORT="${PORT:-3000}"
export WS_PATH="${WS_PATH:-/proxy}"

sed -e "s#__UUID__#${UUID}#g" \
    -e "s#__WS_PATH__#${WS_PATH}#g" \
    -e "s#__PORT__#${PORT}#g" \
    /usr/local/etc/xray/config.json.template > /usr/local/etc/xray/config.json

exec /usr/local/bin/xray run -config /usr/local/etc/xray/config.json
