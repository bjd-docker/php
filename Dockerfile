FROM composer:1.8 AS composer
FROM php:7.3-fpm

RUN apt-get update \
    && apt-get install -y \
        gnupg2 \
        libicu-dev \
        libzip-dev \
        unzip \
        wget \
        zip

RUN pecl install xdebug

RUN docker-php-ext-configure intl \
    && docker-php-ext-configure zip --with-libzip \
    && docker-php-ext-install intl \
    && docker-php-ext-install opcache \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install zip \
    && docker-php-ext-enable xdebug

RUN wget https://downloads.wkhtmltopdf.org/0.12/0.12.5/wkhtmltox_0.12.5-1.stretch_amd64.deb \
    && apt-get install -y ./wkhtmltox_0.12.5-1.stretch_amd64.deb \
    && rm -f ./wkhtmltox_0.12.5-1.stretch_amd64.deb

RUN useradd dev

COPY .bashrc /home/dev/.bashrc
COPY php.ini /usr/local/etc/php/php.ini
COPY --from=composer /usr/bin/composer /usr/bin/composer

RUN chown -R dev:dev /home/dev

USER dev:dev

WORKDIR /app

CMD ["php-fpm"]
