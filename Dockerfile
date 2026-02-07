# Optimized for Telegram Bot
FROM php:8.1-cli

# Install minimal dependencies
RUN apt-get update && apt-get install -y \
    curl \
    zip \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www/html

# Copy files
COPY . .

# Create backups directory
RUN mkdir -p backups && chmod 777 backups

# Start the bot
CMD ["php", "bot.php"]
