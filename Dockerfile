# Use official PHP image
FROM php:8.1-apache

# Install system dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    zip \
    unzip \
    libcurl4-openssl-dev \
    libssl-dev \
    libzip-dev \
    && docker-php-ext-install zip \
    && docker-php-ext-install mysqli \
    && docker-php-ext-enable mysqli

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www/html

# Copy application files
COPY . .

# Create necessary directories with error handling
RUN mkdir -p backups \
    && chmod 777 backups \
    # Create empty files if they don't exist
    && { [ ! -f "movies.csv" ] && touch movies.csv; } \
    && { [ ! -f "users.json" ] && touch users.json; } \
    && { [ ! -f "bot_stats.json" ] && touch bot_stats.json; } \
    && { [ ! -f "movie_requests.json" ] && touch movie_requests.json; } \
    && { [ ! -f "bot_activity.log" ] && touch bot_activity.log; } \
    && { [ ! -f "error.log" ] && touch error.log; } \
    && { [ ! -f "bot.php" ] && touch bot.php; } \
    # Set permissions
    && chmod 777 *.csv *.json *.log \
    && chmod +x bot.php

# Install PHP dependencies if composer.json exists
RUN if [ -f "composer.json" ]; then composer install --no-dev --optimize-autoloader; fi

# Configure Apache
RUN a2enmod rewrite headers expires \
    && echo "ServerName localhost" >> /etc/apache2/apache2.conf \
    && echo "DocumentRoot /var/www/html" >> /etc/apache2/apache2.conf

# Set permissions
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html \
    && chmod -R 777 backups

# Expose port
EXPOSE 80

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD curl -f http://localhost/ || exit 1

# Start command
CMD ["apache2-foreground"]
