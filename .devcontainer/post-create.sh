#!/bin/bash
# Codespaces起動後に毎回実行される。Firefoxが「起動できる実体」か検証する。
# (Ubuntu標準aptのfirefoxはsnapスタブでコンテナ内では動かないため)

echo "=== post-create: Firefox check ==="

if ! command -v firefox >/dev/null 2>&1; then
  echo "WARNING: firefox not found."
  exit 0
fi

# snapスタブ検出: 実バイナリでなければ --version が失敗/文言がsnap関連になる
if firefox --version >/dev/null 2>&1; then
  echo "Firefox OK: $(firefox --version)"
else
  echo "WARNING: 'firefox' exists but does not run (likely Ubuntu snap stub)."
  echo "Fix: rebuild the container (Codespaces ... -> Rebuild Container),"
  echo "     the Dockerfile now installs real Firefox via Mozilla PPA."
  exit 0
fi

# Fluxboxにはデスクトップアイコン機能がないため、右クリックメニュー/ターミナル起動が基本。
# 参考用に .desktop ファイルも置いておく (xdg-open経由などで使える場合あり)
mkdir -p ~/Desktop
cat > ~/Desktop/Firefox.desktop <<'EOF'
[Desktop Entry]
Name=Firefox
Comment=Web Browser
Exec=firefox %u
Icon=firefox
Terminal=false
Type=Application
Categories=Network;WebBrowser;
EOF
chmod +x ~/Desktop/Firefox.desktop
echo "Desktop shortcut created: ~/Desktop/Firefox.desktop"
echo "Tip: Fluxboxでは右クリック->ターミナルを開き 'firefox &' で起動できます。"
