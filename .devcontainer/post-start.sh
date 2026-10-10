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
# 起動直後はポート転送自体が未登録のことがあるためリトライする
attempt=1
max_attempts=6
wait_seconds=10
while [ "$attempt" -le "$max_attempts" ]; do
  if gh codespace ports visibility 6080:public -c "$CODESPACE_NAME"; then
    echo "Port 6080 is now Public."
    exit 0
  fi
  echo "Attempt $attempt/$max_attempts failed. Retrying in ${wait_seconds}s..."
  sleep "$wait_seconds"
  attempt=$((attempt + 1))
done
echo "WARNING: failed to set port visibility after $max_attempts attempts.
  - 組織のポリシーでPublic化が禁止されている可能性があります
  - 手動手順: PORTSタブ -> 6080を右クリック -> Port Visibility -> Public
  - 自分だけ使う場合はPrivateのままでもOK (GitHub認証で開けます)"
exit 0
