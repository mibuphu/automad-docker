FROM nginx:1.15
LABEL MAINTAINER="Minh Bui <mibuphu@gmail.com>"

ENV version 1.0.3

RUN apt-get update \
    && apt-get install -y --no-install-recommends wget \
    php7.0-fpm \
    php7.0-common \
    php7.0-mbstring \
    php7.0-xmlrpc \
    php7.0-sqlite3 \
    php7.0-soap \
    php7.0-gd \
    php7.0-xml \
    php7.0-cli \
    php7.0-curl \
    php7.0-zip \
    ca-certificates \
    supervisor \
    && cd /tmp \
    && mkdir -p /var/www/html \
    && mkdir -p /var/www/html/automad \
    && wget https://bitbucket.org/marcantondahmen/automad/get/${version}.tar.gz \
    && tar -xzf ${version}.tar.gz -C /var/www/html/automad --strip-components 1 \
    && rm ${version}.tar.gz \
    && chown -R nginx:nginx /var/www/html/automad \
    && /bin/bash -c 'chmod -R 755 /var/www/html/automad/' \
    && mkdir -p /etc/nginx/sites-available \
    && mkdir -p /etc/nginx/sites-enabled \ 
    && apt-get clean \
    && rm -rf /var/lib/apt/lists

COPY config/www.conf /etc/php/7.0/fpm/pool.d/www.conf
COPY config/php.ini /etc/php/7.0/fpm/php.ini    
COPY config/automad.conf /etc/nginx/sites-available/automad.conf
COPY config/nginx.conf /etc/nginx/nginx.conf
COPY config/supervisor.conf /etc/supervisor/conf.d/supervisor.conf
COPY config/accounts.php /var/www/html/automad/config

RUN  ln -s /etc/nginx/sites-available/automad.conf /etc/nginx/sites-enabled/automad.conf \
    && mkdir -p /run/php \
    && touch /run/php/php7.0-fpm.sock \
    && touch /run/php/php7.0-fpm.pid \
    && mkdir -p /var/log/supervisor \
    && apt-get purge -y wget \
    ca-certificates \

EXPOSE 80

CMD ["/usr/bin/supervisord"]



