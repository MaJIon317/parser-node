FROM node:latest

# 2. Устанавливаем зависимости для Puppeteer/Chromium
RUN apt-get update && apt-get install -y \
    wget \
    ca-certificates \
    fonts-liberation \
    libappindicator3-1 \
    libasound2 \
    libatk-bridge2.0-0 \
    libatk1.0-0 \
    libcups2 \
    libdbus-1-3 \
    libdrm2 \
    libgbm1 \
    libgtk-3-0 \
    libnspr4 \
    libnss3 \
    libx11-xcb1 \
    libxcomposite1 \
    libxdamage1 \
    libxrandr2 \
    xdg-utils \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# 3. Устанавливаем рабочую директорию
WORKDIR /var/www/parser-node

# 4. Копируем package.json и package-lock.json
COPY package*.json ./

# 5. Устанавливаем зависимости
RUN npm install --production

# 7. Создаём папку для cookies
RUN mkdir -p ./cookies

# 8. Экспонируем порт
EXPOSE 3200

# 9. Запуск сервера
CMD ["node", "server.js"]
