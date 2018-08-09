#!/bin/bash

composer install

if [ "${1#-}" != "$1" ]; then
    set -- php-fpm "$@"
fi

exec "$@"
