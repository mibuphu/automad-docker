FROM nginx:1.15
COPY app /var/www/html/automad
RUN chown -R www-data:www-data /var/www/html/automad \
    && chmod -R 755 /var/www/html/automad/ \
    && apt-get update \
    && apt install -y php7.0-fpm \
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
    && mkdir -p /etc/nginx/sites-available \
    && mkdir -p /etc/nginx/sites-enabled
COPY config/php.ini /etc/php/7/fpm/php.ini    
COPY config/automad /etc/nginx/sites-available/automad    
RUN  ln -s /etc/nginx/sites-available/automad /etc/nginx/sites-enabled/automad

EXPOSE 8000

CMD ["nginx", "-g", "daemon off;"]



