#!/bin/bash
set -e

APP_DIR="/home/adminden/allures-frontend/my-app"
TMP_DIR="/home/adminden/allures-frontend/tmp-deploy"
PM2_NAME="allures-frontend"

echo "Starting deployment..."

# 1. Клоним или обновляем репозиторий во временной папке
if [ -d "$TMP_DIR" ]; then
  echo "Updating temporary directory..."
  cd "$TMP_DIR"
  git reset --hard HEAD
  git clean -fd
  git pull origin main
else
  echo "Cloning repo to temporary directory..."
  git clone https://github.com/Allures-allol/allures-frontend.git "$TMP_DIR"
  cd "$TMP_DIR"
fi

# 2. Устанавливаем зависимости и билдим
echo "Installing dependencies in temporary directory..."
npm install

echo "Building frontend (Next.js) in temporary directory..."
NODE_ENV=production npm run build

# 3. Если билд прошёл — обновляем рабочую директорию
echo "Build successful! Updating working directory..."

# Останавливаем и удаляем старый процесс PM2 (если есть)
if pm2 list | grep -q "$PM2_NAME"; then
  echo "Stopping old PM2 process..."
  pm2 stop "$PM2_NAME"
  pm2 delete "$PM2_NAME"
fi

echo "Copying files from temporary to working directory..."
# Удаляем старые файлы и копируем новые
rm -rf "$APP_DIR"/*
cp -r "$TMP_DIR"/* "$APP_DIR"/

# 4. Запускаем новый процесс PM2
cd "$APP_DIR"
echo "Starting frontend with PM2..."
pm2 start npm --name "$PM2_NAME" -- start

echo "Saving PM2 process list..."
pm2 save

echo "✅ Deployment completed successfully!"

admind
