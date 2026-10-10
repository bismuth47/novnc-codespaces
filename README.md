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
4. 下部の「ポート」タブを開き、`6080 Desktop (noVNC)` が **Public** になっていることを確認（起動時の自動スクリプトでPublic化されます）
   - もしPrivateのままなら: 6080を右クリック → `Port Visibility` → `Public`、またはターミナルで `gh codespace ports visibility 6080:public -c "$CODESPACE_NAME"` を実行
5. `6080` 行の地球儀アイコン（ブラウザーで開く）をクリック
   - `onAutoForward: openPreview` なので自動でプレビューが開く場合もあります
5. 開いたnoVNCページで `Connect` をクリック（パスワード設定なしのためそのまま接続可）
6. Fluxboxデスクトップが表示される。Firefoxの起動は**ターミナルから**行う（Fluxboxにデスクトップアイコン機能はなく、メニューにも出ない場合があるため）:
    - デスクトップ上で右クリック → ターミナル(xterm等)を開く → `firefox &` を実行
    - またはCodespaces側のVS Codeターミナルで `firefox &` を実行（デスクトップ上に開く）
7. 終わったらCodespacesをStopする（課金防止）: `...` メニュー → `Stop codespace`

## 既存のCodespacesを直すには（再ビルド）

Dockerfile修正後は、起動中Codespaceの `...` メニュー → `Rebuild Container` を実行する。
再ビルドせず今すぐ直したい場合は、Codespacesのターミナルで以下を実行:

```bash
sudo apt-get remove -y firefox
sudo apt-get install -y software-properties-common
sudo add-apt-repository -y ppa:mozillateam/ppa
echo -e 'Package: *\nPin: release o=LP-PPA-mozillateam\nPin-Priority: 1001' | sudo tee /etc/apt/preferences.d/mozilla-firefox
sudo apt-get update && sudo apt-get install -y firefox
firefox &
```

## トラブルシュート

- 真っ黒画面/繋がらない: noVNCページをリロードして再度 `Connect`。Codespacesの「ポート」タブで6080がForward済みか確認
- Firefoxがクラッシュする: タブを開きすぎない。Codespacesマシンを高スペック(4core~)にすると安定
- 日本語キーボード: デフォルトEN配列。必要ならデスクトップ内ターミナルで `setxkbmap jp` を試す
