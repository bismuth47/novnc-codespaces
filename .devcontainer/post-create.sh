#!/bin/bash
set -e

echo "=== post-create: Firefox & desktop shortcut check ==="

if command -v firefox >/dev/null 2>&1; then
  echo "Firefox OK: $(firefox --version || true)"
else
  echo "WARNING: firefox not found. Run: sudo apt-get update && sudo apt-get install -y firefox"
  exit 0
fi

# Fluxboxデスクトップから一発起動できるようショートカット作成
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
