# fcitx5-skin

个人自用的 fcitx5 皮肤。灵感来自 macOS Sonoma 原生输入法候选窗（深色、单候选蓝色高亮、紧凑单行布局）。

## 预览

（截图待补）

## 安装

```bash
git clone https://github.com/<你的用户名>/fcitx5-skin.git
mkdir -p ~/.local/share/fcitx5/themes
cp -r fcitx5-skin/theme ~/.local/share/fcitx5/themes/fcitx5-skin
```

然后在 `~/.config/fcitx5/conf/classicui.conf` 里启用：

```ini
Theme=fcitx5-skin
```

重启 fcitx5 生效：

```bash
fcitx5 -rd
```

## 说明

- 主题基于 SVG 九宫格拉伸，圆角在任意尺寸下保持不变
- `ScaleWithDPI=False`：适配 niri/Hyprland 等 Wayland 分数缩放环境（fcitx5 ≥ 5.1.22 下建议配合 `EnableFractionalScale=False` 使用）
- 配套建议：候选字号 10–12、Rime `menu/page_size = 7`、开启客户端预编辑（拼音内嵌到应用），观感更接近原生

## 文件

```
theme/
├── theme.conf     # 主题配置（颜色、边距）
├── panel.svg      # 候选框底板
└── highlight.svg  # 选中药丸
```

## License

MIT
