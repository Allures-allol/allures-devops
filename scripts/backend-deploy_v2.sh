adminden@AlluresBackendSrv:~$ cat hooks/deploy-service.sh
#!/bin/bash
set -e

SERVICE=$1
LOG_FILE="/home/adminden/hooks/deploy.log"
REPORT_DIR="$HOME/zap-reports"
mkdir -p "$REPORT_DIR"

# Приводим параметр к нижнему регистру и убираем "-service" на конце
SERVICE_KEY=$(echo "$SERVICE" | sed 's/-service$//' | tr '[:upper:]' '[:lower:]')

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Starting deploy for: $SERVICE (mapped as $SERVICE_KEY)" >> $LOG_FILE

# Список сервисов и портов
declare -A PORT_MAP
PORT_MAP=(
    ["product"]=8000
    ["sales"]=8001
    ["review"]=8002
    ["auth"]=8003
    ["profile"]=8004
    ["payment"]=8005
    ["discount"]=8006
    ["dashboard"]=8007
    ["admin"]=8010
    ["subscription"]=8011
)

# Проверяем, что сервис существует
if [[ "$SERVICE" != "ALL" && -z "${PORT_MAP[$SERVICE_KEY]}" ]]; then
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Unknown service: $SERVICE" >> $LOG_FILE
    exit 1
fi

# Функция деплоя одного сервиса
deploy_one() {
    local SVC=$1
    local PORT=${PORT_MAP[$SVC]}
    local IMAGE_NAME="denstep123/${SVC,,}-service"

    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Deploying $SVC on port $PORT using image $IMAGE_NAME..." >> $LOG_FILE

    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Stopping old container..." >> $LOG_FILE
    docker stop $SVC >> $LOG_FILE 2>&1 || echo "[$(date '+%Y-%m-%d %H:%M:%S')] No container to stop" >> $LOG_FILE

    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Removing old container..." >> $LOG_FILE
    docker rm $SVC >> $LOG_FILE 2>&1 || echo "[$(date '+%Y-%m-%d %H:%M:%S')] No container to remove" >> $LOG_FILE

    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Pulling latest image..." >> $LOG_FILE
    docker pull $IMAGE_NAME >> $LOG_FILE 2>&1 || echo "[$(date '+%Y-%m-%d %H:%M:%S')] Failed to pull image $IMAGE_NAME" >> $LOG_FILE

    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Running new container..." >> $LOG_FILE
    docker run -d --name $SVC --env-file /home/adminden/.env -p $PORT:8000 --restart unless-stopped $IMAGE_NAME >> $LOG_FILE 2>&1

    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Deploy finished for $SVC" >> $LOG_FILE
}


# Если ALL — обновляем все
if [[ "$SERVICE" == "ALL" ]]; then
    for svc in "${!PORT_MAP[@]}"; do
        deploy_one $svc
    done
else
    deploy_one $SERVICE_KEY
fi

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Cleaning up unused images..." >> $LOG_FILE
docker image prune -f >> $LOG_FILE 2>&1

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Deploy script finished" >> $LOG_FILE
