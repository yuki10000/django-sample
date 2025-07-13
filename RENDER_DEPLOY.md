# Render デプロイメントガイド

## 概要
このプロジェクトをRenderにデプロイするための設定が完了しています。
開発環境と本番環境で異なるDockerfileを使用し、開発環境の動作を保持しつつ本番環境を最適化しています。

## Dockerファイル構成
- **`Dockerfile`**: 開発環境用（Django開発サーバー）
- **`Dockerfile.prod`**: 本番環境用（Gunicorn + 静的ファイル収集）
- **`render.yaml`**: `Dockerfile.prod`を使用してRenderにデプロイ

## デプロイ手順

### 1. GitHubリポジトリにプッシュ
```bash
git add .
git commit -m "Add Render deployment configuration"
git push origin main
```

### 2. Renderでプロジェクトを作成
1. [Render Dashboard](https://dashboard.render.com/)にログイン
2. "New +" → "Blueprint" を選択
3. GitHubリポジトリを接続
4. `render.yaml`ファイルが自動検出されます

### 3. 環境変数の設定
以下の環境変数がRenderで自動設定されます：
- `ENV=production`
- `DEBUG=false` 
- `SECRET_KEY` (自動生成)
- `ALLOWED_HOSTS=*.onrender.com`
- `DATABASE_URL` (PostgreSQLから自動設定)

手動で設定が必要な環境変数：
- `FRONTEND_URL`: フロントエンドのURL (例: https://your-frontend.vercel.app)

### 4. デプロイ後の確認
- WebサービスのURLでAPIにアクセス可能
- PostgreSQLデータベースが自動作成・接続
- 静的ファイルがWhiteNoiseで配信

## 本番環境の特徴
- Gunicornでの本番サーバー実行
- PostgreSQLデータベース使用
- WhiteNoiseによる静的ファイル配信
- CORS設定済み
- セキュリティ設定最適化

## トラブルシューティング
- ログはRender Dashboardで確認可能
- データベースマイグレーション: `python manage.py migrate`
- 管理者ユーザー作成: `python manage.py createsuperuser`
