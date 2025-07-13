# 環境構築ガイド

## 環境ファイルの準備

- `.env.development`がgitignoreされているので手動で受け取ってください
- .env系のファイルをリポジトリのルートディレクトリに保存

## 開発ファイルの立ち上げ

- VS Codeのdev containerを利用してコンテナーを開く

- 以下のコマンドを実行し、サーバーを立ち上げ

    ```bash
    python manage.py runserver 0.0.0.0:8000
    ```
