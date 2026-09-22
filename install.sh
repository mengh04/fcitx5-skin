#!/usr/bin/env bash
# fcitx5-skin 安装脚本
set -euo pipefail

THEME_NAME="fcitx5-skin"
THEME_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/fcitx5/themes/$THEME_NAME"
CONF_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/fcitx5"
CLASSICUI="$CONF_DIR/conf/classicui.conf"

# 1. 复制主题
mkdir -p "$(dirname "$THEME_DIR")"
rm -rf "$THEME_DIR"
cp -r "$(dirname "$0")/theme" "$THEME_DIR"
echo "✓ 主题已安装到 $THEME_DIR"

# 2. 修改 classicui.conf 的 Theme（没有则创建）
mkdir -p "$CONF_DIR/conf"
if [ -f "$CLASSICUI" ]; then
    cp "$CLASSICUI" "$CLASSICUI.bak.$(date +%Y%m%d%H%M%S)"
    if grep -q '^Theme=' "$CLASSICUI"; then
        sed -i "s|^Theme=.*|Theme=$THEME_NAME|" "$CLASSICUI"
    else
        echo "Theme=$THEME_NAME" >> "$CLASSICUI"
    fi
else
    printf 'Theme=%s\n' "$THEME_NAME" > "$CLASSICUI"
fi
echo "✓ 已将 Theme 设为 $THEME_NAME（原配置已备份）"

# 3. 提示重启
if pgrep -x fcitx5 >/dev/null 2>&1; then
    echo "→ 请运行 fcitx5 -rd 使其生效"
else
    echo "→ fcitx5 未运行，下次启动时自动生效"
fi
