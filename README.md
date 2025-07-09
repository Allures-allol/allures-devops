# Allures DevOps

Этот репозиторий отвечает за DevOps-инфраструктуру проекта **Allures@Allol** — маркетплейса.

## 📦 Стек
- CI/CD: heroku
- Домены: Porkbun.com - alluresallol.com
- SSL: Porkbun.com/Heroku SSL
- Мониторинг:
- Безопасность:

# 📁 Структура репозитория allures-devops
- `allures-devops/`
-   `.github/ `
-    `└── workflows/`
-    `deploy.yml`        # CI/CD пайплайн
- `docker/`
-   `├── backend.Dockerfile `   # Dockerfile для FastAPI
-   `├── frontend.Dockerfile`   # Dockerfile для Next.js (если не Vercel)
-   `└── docker-compose.yml `   # Общий запуск в dev/test
-   `nginx/`
-   `└── default.conf   `       # Прокси для бэкенда/фронта (если нужно)
-   `infra/`
-   `├── railway.json `         # Railway/Infra описание (если через API)
-   `└── domain-setup.md `      # Как купить и прикрепить домен
-   `certs/  `                  # Папка под SSL-сертификаты (НЕ коммить .key!)
-   `scripts/`
-   `├── deploy.sh`             # Ручной деплой (если надо)
-   `└── check-vulns.sh`        # Скрипт на уязвимости
-   `README.md`
-   `SECURITY.md`              # Политика безопасности, отчёты об уязвимостях
-   `.gitignore`

# allures-devops
