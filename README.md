# Codespaces + noVNC リモートデスクトップ

GitHub Codespaces上でLinuxデスクトップ(Fluxbox)を起動し、手元のブラウザからnoVNC経由で操作できます。デスクトップ内にはFirefox入りですぐネットサーフィン可能です。

## ファイル構成

```
.devcontainer/
  devcontainer.json  # desktop-lite feature + 6080自動フォワード設定
  Dockerfile         # Firefox導入
  post-create.sh     # Firefox確認 + デスクトップショートカット作成
```

## 使い方（初心者向け）

1. このリポジトリをGitHubにpushする
2. GitHub上で `<> Code` → `Codespaces` タブ → `Create codespace on main` をクリック
3. 数分待ってCodespaces(VS Code Web)が起動する
4. 下部の「ポート」タブを開き、`6080 Desktop (noVNC)` の地球儀アイコン（ブラウザーで開く）をクリック
   - `onAutoForward: openPreview` なので自動でプレビューが開く場合もあります
5. 開いたnoVNCページで `Connect` をクリック（パスワード設定なしのためそのまま接続可）
6. Fluxboxデスクトップが表示される
   - 右クリック → `Applications` → `Web Browsing` → `Firefox` でブラウザ起動
   - またはデスクトップ内のターミナルで `firefox &` を実行
7. 終わったらCodespacesをStopする（課金防止）: `...` メニュー → `Stop codespace`

## トラブルシュート

- 真っ黒画面/繋がらない: noVNCページをリロードして再度 `Connect`。Codespacesの「ポート」タブで6080がForward済みか確認
- Firefoxがクラッシュする: タブを開きすぎない。Codespacesマシンを高スペック(4core~)にすると安定
- 日本語キーボード: デフォルトEN配列。必要ならデスクトップ内ターミナルで `setxkbmap jp` を試す
