# Supabase + Render デプロイガイド

## 初期設定

一番最初にsupabaseおよびrenderでデプロイする人が実行する設定

### 1. Supabaseプロジェクトの作成

1. [Supabase](https://supabase.com/)にアクセスしてアカウントを作成
2. 「New Project」をクリックして新しいプロジェクトを作成
3. プロジェクト名：`kaede-backend`（任意）
4. データベースパスワードを設定
5. リージョンを選択（`Northeast Asia (Tokyo)`を選択）

### 2. Supabaseデータベース情報の取得

プロジェクト作成後、**Connect** → **Session pooler**からデータベースのURLを取得

### 3. Renderアカウントの作成とリポジトリ連携

1. [Render](https://render.com/)にアクセスしてアカウントを作成
2. GitHubアカウントと連携
3. このリポジトリ（kaede-backend）へのアクセス権限を付与

### 4. Render Web Serviceの作成

1. Renderダッシュボードで「New +」→「Blueprint」を選択
2. GitHubリポジトリから`kaede-backend`を選択

### 5. 環境変数の設定

Render Web Serviceの「Environment」タブで以下の環境変数を設定

```bash
# Django設定
SECRET_KEY=ランダムな50文字以上の文字列
DEBUG=false
ALLOWED_HOSTS=kaede-backend.onrender.com,localhost,127.0.0.1,0.0.0.0

# データベース設定（Supabaseから取得）
DATABASE_URL=Supabaseの「Connect」→「Session pooler」から取得

# 本番環境設定
ENV=production

# フロントエンドのURL
FRONTEND_URL=https://kaede-frontend.vercel.app
```

### 6. 必要なファイルの確認

デプロイ前に以下のファイルが存在することを確認：

- `Dockerfile.prod`: 本番用Dockerファイル
- `start.sh`: 起動スクリプト
- `render.yaml`: Render設定ファイル
- `requirements.txt`: Python依存関係

### 7. 初回デプロイの実行

1. 上記設定完了後、「Manual Deploy」→「Deploy latest commit」を実行
2. デプロイログを確認してエラーがないことを確認
3. デプロイ完了後、提供されるURLでアプリケーションにアクセス
4. `/admin`でDjango管理画面にアクセスできることを確認

### 8. スーパーユーザーの作成

デプロイ成功後、Renderの「Shell」タブから以下のコマンドを実行
注: ShellはRenderに課金しないと利用できない

```bash
python manage.py createsuperuser
```

### 9. 初期データの投入（必要に応じて）

```bash
python manage.py loaddata initial_data.json
```

## 毎回のデプロイフロー

- このリポジトリのmainブランチを更新したら自動的にデプロイが実行される
- `render.yaml`、`Dockrefile.prod`、`start.sh`の内容に処理が記述されている
