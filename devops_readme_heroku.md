# ⚙️ Allures\@Allol DevOps Setup & Deployment Guide

Репозиторий отвечает за **деплой**, **настройку окружения**, **Heroku-менеджмент**, поддержку **CI/CD** и **DevOps-процессы** для проекта **Allures\@Allol**.

---

## 📁 Клонирование репозитория

### HTTPS (универсально)

```bash
git clone https://github.com/Allures-allol/allures-devops.git
cd allures-devops
```

### SSH (если есть SSH-ключ)

```bash
git clone git@github.com:Allures-allol/allures-devops.git
cd allures-devops
```

📌 [Как настроить SSH-ключи на GitHub](https://docs.github.com/en/authentication/connecting-to-github-with-ssh)

---

## 💻 Установка зависимостей и инструментов

### 🐧 Linux

```bash
sudo apt update
sudo apt install git heroku docker.io -y
heroku login
```

### 🪟 Windows

1. Установи:

   - [Git для Windows](https://git-scm.com/download/win)
   - [Heroku CLI](https://devcenter.heroku.com/articles/heroku-cli#download-and-install)
   - [Docker Desktop](https://www.docker.com/products/docker-desktop)

2. Запусти Git Bash или PowerShell.

3. Выполни:

```bash
heroku login
```

---

## 🚀 Деплой на Heroku

### Привязать репозиторий к Heroku-приложению:

```bash
heroku git:remote -a <heroku-app-name>
```

### Запушить изменения:

```bash
git add .
git commit -m "feat: deploy update"
git push heroku main
```

Или если ты на ветке `heroku-upd`:

```bash
git push heroku heroku-upd:main
```

---

## 📜 Просмотр логов

### В реальном времени:

```bash
heroku logs --tail
```

### Последние 100 строк:

```bash
heroku logs -n 100
```

---

## 🌐 Переменные окружения (ENV)

### Установка:

```bash
heroku config:set KEY=value
```

Пример:

```bash
heroku config:set DATABASE_URL=postgres://...
heroku config:set JWT_SECRET=supersecret
```

### Просмотр:

```bash
heroku config
```

---

## 🔗 Проверка API и фронта

- Открой в браузере:

  - [https://alluresallol.com](https://alluresallol.com) (фронт)
  - [https://api.alluresallol.com](https://api.alluresallol.com) (бэк)

- Проверка через curl:

```bash
curl https://api.alluresallol.com/auth/status
```

---

## 🧰 Команды Heroku

| Команда                       | Назначение                      |
| ----------------------------- | ------------------------------- |
| `heroku ps:scale web=1`       | Запуск dyno                     |
| `heroku restart`              | Перезапуск приложения           |
| `heroku open`                 | Открыть сайт в браузере         |
| `heroku config`               | Показать ENV-переменные         |
| `heroku config:set KEY=value` | Установить переменную окружения |
| `heroku logs --tail`          | Логи в реальном времени         |

---

## 🧾 Локальная разработка (`.env`)

Создай `.env` в корне проекта:

```env
DATABASE_URL=postgres://...
JWT_SECRET=...
BACKEND_URL=https://api.alluresallol.com
```

---

## 🔐 Домены и SSL

- `api.alluresallol.com` — CNAME на `herokudns.com`
- `alluresallol.com` — ALIAS/CNAME на Heroku DNS или Vercel
- SSL можно:
  - Использовать бесплатный от Heroku (ACM)
  - Или платный с Porkbun (но тогда отключить Heroku SSL)

---

## ⚙️ CI/CD (будет позже)

- Планируется автоматизация с GitHub Actions.
- При пуше в `main` будет запускаться деплой на прод.

---

## 👥 Ответственные

| Роль     | Имя GitHub |
| -------- | ---------- |
| DevOps   | @DenVR     |
| Backend  | @backender |
| Frontend | @frontendy |

---

> Часть дипломного проекта [Allures@Allol](https://github.com/Allures-allol)

