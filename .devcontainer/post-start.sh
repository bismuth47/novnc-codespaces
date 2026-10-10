#!/bin/bash
# Codespaces起動のたびに実行される。noVNCポート(6080)をPublicに自動設定する。
# (CodespacesのフォワードポートはデフォルトPrivateのため、手動切替が必要になる問題への対処)
# Publicにしないと、手元のブラウザから転送URLにアクセスできない。

if [ -z "$CODESPACE_NAME" ]; then
  echo "Not running in Codespaces (CODESPACE_NAME unset). Skip port visibility."
  exit 0
fi

if ! command -v gh >/dev/null 2>&1; then
  echo "WARNING: gh CLI not found. Set port 6080 visibility to Public manually in PORTS tab."
  exit 0
fi

echo "Setting port 6080 visibility to public (codespace: $CODESPACE_NAME)..."
if gh codespace ports visibility 6080:public -c "$CODESPACE_NAME"; then
  echo "Port 6080 is now Public."
else
  echo "WARNING: failed to set port visibility."
  echo "  - 組織のポリシーでPublic化が禁止されている可能性があります"
  echo "  - 手動手順: PORTSタブ -> 6080を右クリック -> Port Visibility -> Public"
fi
