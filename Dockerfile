FROM node:18-bookworm

# Устанавливаем зависимости
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    tini \
    curl \
    unzip \
    ca-certificates \
    libmagic1 \
    ffmpeg \
    libssl-dev \
    zlib1g-dev \
    libpq-dev \
    build-essential \
    git \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Установка n8n
ENV N8N_VERSION=1.93.0
RUN npm install -g n8n@${N8N_VERSION} && npm cache clean --force

# Устанавливаем ноду Telepilot
USER node
WORKDIR /home/node/.n8n

# Установка зависимостей проекта
RUN npm init -y
RUN npm install @telepilotco/n8n-nodes-telepilot

# Открываем порт
EXPOSE 5678

# Запуск от имени node с tini
ENTRYPOINT ["tini", "--"]
CMD ["n8n"]
