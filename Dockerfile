FROM nginx:1.15
RUN apt-get update \
    && apt-get install -y --no-install-recommends wget \
    unzip \
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
    && wget https://bitbucket.org/marcantondahmen/automad/get/b218af08c7ce.zip \
    && unzip b218af08c7ce \
    && mkdir -p /var/www/html \
    && mv marcantondahmen-automad-b218af08c7ce /var/www/html/automad \
    && chown -R www-data:www-data /var/www/html/automad \
    && /bin/bash -c 'chmod -R 755 /var/www/html/automad/' \
    && mkdir -p /etc/nginx/sites-available \
    && mkdir -p /etc/nginx/sites-enabled \ 
    && rm /etc/nginx/nginx.conf

COPY config/php.ini /etc/php/7.0/fpm/php.ini    
COPY config/automad.conf /etc/nginx/sites-available/automad.conf
COPY config/nginx.conf /etc/nginx/nginx.conf
RUN  ln -s /etc/nginx/sites-available/automad.conf /etc/nginx/sites-enabled/automad.conf \
    && mv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf.source \
    && apt-get remove -y wget \
    unzip \
    ca-certificates \
    && apt-get clean

EXPOSE 80

CMD /etc/init.d/php7.0-fpm start && nginx -g "daemon off;"



