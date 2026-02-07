# Dockerfile
FROM php:8.2-apache

# System dependencies install karo
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    && docker-php-ext-install mbstring \
    && docker-php-ext-install xml \
    && docker-php-ext-install bcmath

# Composer install karo
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Apache configuration enable karo
RUN a2enmod rewrite headers

# Working directory set karo
WORKDIR /var/www/html

# PHP configuration copy karo
COPY php.ini /usr/local/etc/php/conf.d/custom.ini

# Port expose karo (Render.com provides PORT env variable)
EXPOSE 8080

# Server configuration for Render.com
RUN sed -i 's/Listen 80/Listen 8080/g' /etc/apache2/ports.conf \
    && sed -i 's/:80/:8080/g' /etc/apache2/sites-available/*.conf \
    && sed -i 's/80/8080/g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

# App files copy karo
COPY . .

# File permissions set karo
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html \
    && chmod -R 777 /var/www/html/backups \
    && chmod 666 /var/www/html/*.csv /var/www/html/*.json /var/www/html/*.log

# Entrypoint script
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["apache2-foreground"]