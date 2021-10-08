FROM php:8.0-fpm-alpine

RUN apk update \
    && apk add --no-cache git mysql-client libzip-dev curl libmcrypt libmcrypt-dev openssh-client icu-dev \
    libxml2-dev freetype-dev libpng-dev libjpeg-turbo-dev g++ make autoconf openssl-dev sqlite-dev unzip bash git shadow \
    && docker-php-source extract \
	&& docker-php-ext-install sockets \
    && docker-php-source delete \
    && docker-php-ext-install pdo pdo_mysql soap intl zip \
    && rm -rf /tmp/*

RUN apk add --update --no-cache \
        freetype-dev \
        libjpeg-turbo-dev \
        libmcrypt-dev \
        libpng-dev \
    && docker-php-ext-configure gd --with-freetype=/usr/include/ --with-jpeg=/usr/include/ \
    && docker-php-ext-install -j"$(getconf _NPROCESSORS_ONLN)" gd

ENV COMPOSER_ALLOW_SUPERUSER=1

RUN wget https://getcomposer.org/installer -O - -q| php -- --install-dir=/usr/local/bin --filename=composer \
    && composer --version

# xdebug
ENV XDEBUG_VERSION=3.1.0
RUN apk --no-cache add --virtual .build-deps \
        g++ \
        autoconf \
        make && \
    pecl install xdebug-${XDEBUG_VERSION} && \
    docker-php-ext-enable xdebug && \
    apk del .build-deps && \
    rm -r /tmp/pear/*

RUN echo -e "xdebug.start_with_request=trigger\n\
        xdebug.discover_client_host=true\n\
        log=/tmp/xdebug.log\n\
        xdebug.log_level=0\n\
        xdebug.mode=debug\n\
        xdebug.client_host=host.docker.internal" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

RUN echo -e "memory_limit=1G\n\
    error_reporting=E_ALL & ~E_NOTICE" >> /usr/local/etc/php/conf.d/docker-php-extras.ini;

RUN usermod -u 1000 www-data \
    && groupmod -g 1000 www-data

CMD ["php-fpm", "-F"]

USER www-data
WORKDIR /var/www/html

EXPOSE 9000
