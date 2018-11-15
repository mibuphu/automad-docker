FROM nginx:1.15-alpine
LABEL MAINTAINER="Minh Bui <mibuphu@gmail.com>"

ENV version 1.0.3

RUN apk update \
    && apk add --no-cache php7 \
    php7-session \
    php7-fpm \
    php7-common \
    php7-mbstring \
    php7-xmlrpc \
    php7-sqlite3 \
    php7-soap \
    php7-gd \
    php7-xml \
    php7-curl \
    php7-zip \
    php7-json \
    wget \
    ca-certificates \
    supervisor \
    tar \
    bash \
    && cd /tmp \
    && mkdir -p /var/www/html \
    && mkdir -p /var/www/html/automad \
    && wget https://bitbucket.org/marcantondahmen/automad/get/${version}.tar.gz \
    && tar -xzf ${version}.tar.gz -C /var/www/html/automad --strip-components 1 \
    && rm ${version}.tar.gz \
    && chown -R nginx:nginx /var/www/html/automad \
    && chmod -R 755 /var/www/html/automad/ \
    && mkdir -p /etc/nginx/sites-available \
    && mkdir -p /etc/nginx/sites-enabled 

COPY config/www.conf /etc/php7/php-fpm.d/www.conf
COPY config/php.ini /etc/php7/php.ini    
COPY config/automad.conf /etc/nginx/sites-available/automad.conf
COPY config/nginx.conf /etc/nginx/nginx.conf
COPY config/supervisor.conf /etc/supervisor/conf.d/supervisor.conf
COPY config/accounts.php /var/www/html/automad/config

RUN  ln -s /etc/nginx/sites-available/automad.conf /etc/nginx/sites-enabled/automad.conf \
    && mkdir -p /run/php \
    && touch /run/php/php7-fpm.sock \
    && touch /run/php/php7-fpm.pid \
    && mkdir -p /var/log/supervisor \
    && apk del wget \
    ca-certificates \
    tar \
    bash

EXPOSE 80

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisor.conf"]



