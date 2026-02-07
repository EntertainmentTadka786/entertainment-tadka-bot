# Dockerfile - MINIMAL VERSION

FROM php:8.2-apache

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl libpng-dev libonig-dev libxml2-dev zip unzip \
    && docker-php-ext-install mbstring xml bcmath

# Enable Apache modules
RUN a2enmod rewrite headers

# Set working directory
WORKDIR /var/www/html

# Copy files
COPY . .

# Change port for Render.com
RUN sed -i 's/Listen 80/Listen 8080/g' /etc/apache2/ports.conf \
    && sed -i 's/:80/:8080/g' /etc/apache2/sites-available/*.conf

# Expose Render.com port
EXPOSE 8080

# Start Apache
CMD ["apache2-foreground"]
