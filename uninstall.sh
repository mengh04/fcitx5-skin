#!/usr/bin/env bash
# fcitx5-skin 卸载脚本
set -euo pipefail

THEME_NAME="fcitx5-skin"
THEME_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/fcitx5/themes/$THEME_NAME"
CLASSICUI="${XDG_CONFIG_HOME:-$HOME/.config}/fcitx5/conf/classicui.conf"

# 1. 删除主题目录
if [ -d "$THEME_DIR" ]; then
    rm -rf "$THEME_DIR"
    echo "✓ 已删除 $THEME_DIR"
else
    echo "· 主题目录不存在，跳过"
fi

# 2. 恢复 Theme 设置
if [ -f "$CLASSICUI" ] && grep -q "^Theme=$THEME_NAME" "$CLASSICUI"; then
    # 找最近的备份，有则恢复
    LATEST_BAK=$(ls -t "$CLASSICUI".bak.* 2>/dev/null | head -1 || true)
    if [ -n "$LATEST_BAK" ]; then
        cp "$LATEST_BAK" "$CLASSICUI"
        echo "✓ 已从备份恢复 classicui.conf（$LATEST_BAK）"
    else
        # 没备份就指回默认主题
        sed -i "s|^Theme=.*|Theme=default|" "$CLASSICUI"
        echo "✓ 未找到备份，Theme 已重置为 default"
    fi
else
    echo "· 当前未使用本主题，配置未改动"
fi

echo "→ 如 fcitx5 正在运行，请运行 fcitx5 -rd 生效"
