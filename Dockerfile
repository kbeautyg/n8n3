FROM node:18-slim

# Устанавливаем tini (инициатор) для корректной обработки сигналов и процессов
RUN apt-get update && apt-get install -y --no-install-recommends tini && apt-get clean && rm -rf /var/lib/apt/lists/*

# Устанавливаем n8n определённой версии
ENV N8N_VERSION=1.93.0
RUN npm install -g n8n@${N8N_VERSION} && npm cache clean --force

# Открываем порт для UI n8n
EXPOSE 5678

# Запускаем процесс от непривилегированного пользователя node
USER node

# Используем tini в качестве entrypoint
ENTRYPOINT ["tini", "--"]

# Запуск n8n по умолчанию
CMD ["n8n"]
