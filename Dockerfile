FROM nginx:1.15
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
    && cd /tmp \
    && mkdir -p /var/www/html \
    && mkdir -p /var/www/html/automad \
    && wget https://bitbucket.org/marcantondahmen/automad/get/${version}.tar.gz \
    && tar -xzf ${version}.tar.gz -C /var/www/html/automad --strip-components 1 \
    && rm ${version}.tar.gz \
    && chown -R www-data:www-data /var/www/html/automad \
    && /bin/bash -c 'chmod -R 755 /var/www/html/automad/' \
    && mkdir -p /etc/nginx/sites-available \
    && mkdir -p /etc/nginx/sites-enabled \ 
    && rm /etc/nginx/nginx.conf \
    && apt-get clean

COPY config/php.ini /etc/php/7.0/fpm/php.ini    
COPY config/automad.conf /etc/nginx/sites-available/automad.conf
COPY config/nginx.conf /etc/nginx/nginx.conf
RUN  ln -s /etc/nginx/sites-available/automad.conf /etc/nginx/sites-enabled/automad.conf \
    && mv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf.source \
    && apt-get remove -y wget \
    ca-certificates

EXPOSE 80

CMD /etc/init.d/php7.0-fpm start && nginx -g "daemon off;"



