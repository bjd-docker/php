FROM composer:1.6 AS composer
FROM php:7.2-fpm

RUN apt-get update \
    && apt-get install -y \
        gnupg2 \
        libicu-dev \
        libz-dev \
        unzip \
        zip

RUN pecl install xdebug

RUN docker-php-ext-configure intl \
    && docker-php-ext-install intl \
    && docker-php-ext-install opcache \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install zip \
    && docker-php-ext-enable xdebug

RUN useradd dev

COPY .bashrc /home/dev/.bashrc
COPY entrypoint.sh /usr/local/bin/php-entrypoint
COPY php.ini /usr/local/etc/php/php.ini
COPY --from=composer /usr/bin/composer /usr/bin/composer

RUN chown -R dev:dev /home/dev

USER dev:dev

WORKDIR /app

CMD ["php-fpm"]

ENTRYPOINT ["php-entrypoint"]
