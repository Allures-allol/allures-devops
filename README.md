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
- [x] CI/CD для backend через Railway
- [x] CI/CD для frontend через Vercel
- [ ] Docker сборка и проверка
- [ ] Проверка на уязвимости
- [ ] Мониторинг (healthcheck, error tracking)
# allures-devops
