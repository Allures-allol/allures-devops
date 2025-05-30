# Allures DevOps

Этот репозиторий отвечает за DevOps-инфраструктуру проекта **Allures@Allol** — маркетплейса.

## 📦 Стек
- CI/CD: GitHub Actions + Railway + Vercel
- Docker: Backend/Frontend контейнеризация
- Домены: Cloudflare / Namecheap
- SSL: Let's Encrypt / Cloudflare SSL
- Мониторинг: Railway Logs + Healthcheck endpoints
- Безопасность: Уязвимости сканируются с помощью Trivy/Grype

## 📁 Структура
- `.github/workflows/` — GitHub Actions
- `docker/` — Dockerfile'ы и Compose
- `infra/` — домены, облака, railway конфиги
- `scripts/` — bash-скрипты
- `certs/` — SSL (в .gitignore)

## 📋 Задачи
- [ ] CI/CD для backend через Railway
- [ ] CI/CD для frontend через Vercel
- [ ] Docker сборка и проверка
- [ ] Проверка на уязвимости
- [ ] Мониторинг (healthcheck, error tracking)

# Структура репозитория allures-devops
allures-devops/
├── .github/
│   └── workflows/
│       └── deploy.yml        # CI/CD пайплайн
├── docker/
│   ├── backend.Dockerfile    # Dockerfile для FastAPI
│   ├── frontend.Dockerfile   # Dockerfile для Next.js (если не Vercel)
│   └── docker-compose.yml    # Общий запуск в dev/test
├── nginx/
│   └── default.conf          # Прокси для бэкенда/фронта (если нужно)
├── infra/
│   ├── railway.json          # Railway/Infra описание (если через API)
│   └── domain-setup.md       # Как купить и прикрепить домен
├── certs/                    # Папка под SSL-сертификаты (НЕ коммить .key!)
├── scripts/
│   ├── deploy.sh             # Ручной деплой (если надо)
│   └── check-vulns.sh        # Скрипт на уязвимости
├── README.md
├── SECURITY.md              # Политика безопасности, отчёты об уязвимостях
└── .gitignore

# allures-devops
