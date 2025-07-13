#!/bin/bash

# 本番環境起動スクリプト
# マイグレーション → 静的ファイル収集 → Gunicorn起動

echo "Starting production deployment..."

# データベースマイグレーション
echo "Running database migrations..."
python manage.py migrate --noinput

# 静的ファイル収集
echo "Collecting static files..."
python manage.py collectstatic --noinput

# Gunicorn起動
echo "Starting Gunicorn server..."
exec gunicorn djangosample.wsgi:application --bind 0.0.0.0:$PORT --workers 4
