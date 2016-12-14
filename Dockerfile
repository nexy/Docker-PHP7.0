FROM php:7.0-apache
MAINTAINER Ricardo Coelho <ricardo@nexy.com.br>
COPY config/php.ini /usr/local/etc/php/
COPY src/ /var/www/html/
RUN apt-get update
RUN apt-get install --no-install-recommends -y \
        libpq-dev \
        libicu-dev \
        libcurl4-openssl-dev \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
    && docker-php-ext-install -j$(nproc) iconv mcrypt pgsql pdo pdo_pgsql mysqli \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd intl curl json mbstring zip
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
chmod +x /usr/local/bin/composer
