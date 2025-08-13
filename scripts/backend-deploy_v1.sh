#!/bin/bash
set -e

IMAGE="denstep123/allures-alloll-monolit:latest"
CONTAINER_NAME="allures-monolit"
ENV_FILE="/home/adminden/.env"  # полный путь к .env
LOGFILE="/home/adminden/hooks/deploy-monolit.log"

echo "[HOOK] Update started at $(date)" | tee -a "$LOGFILE"

echo "[HOOK] Pulling latest image..." | tee -a "$LOGFILE"
docker pull $IMAGE 2>&1 | tee -a "$LOGFILE"

echo "[HOOK] Cleaning up old images..." | tee -a "$LOGFILE"
PRUNE_OUTPUT=$(docker image prune -af)
echo "$PRUNE_OUTPUT" | tee -a "$LOGFILE"

echo "[HOOK] Stopping old container (if exists)..." | tee -a "$LOGFILE"
docker stop $CONTAINER_NAME 2>&1 || true | tee -a "$LOGFILE"
docker rm $CONTAINER_NAME 2>&1 || true | tee -a "$LOGFILE"

echo "[HOOK] Starting new container..." | tee -a "$LOGFILE"
docker run -d \
    --name $CONTAINER_NAME \
    --env-file $ENV_FILE \
    -p 8008:8000 \
    --restart unless-stopped \
    $IMAGE 2>&1 | tee -a "$LOGFILE"

echo "[HOOK] Update completed at $(date)" | tee -a "$LOGFILE"
echo "----------------------------------------" | tee -a "$LOGFILE"
