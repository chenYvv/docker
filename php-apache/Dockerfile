FROM php:7.3.6-apache

# 工作目录
WORKDIR /var/www/html

# 时区
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# php.ini
COPY ./php.ini.bak /usr/local/etc/php/php.ini.bak

# apache 配置
COPY ./apache2.conf /etc/apache2/apache2.conf

# ini.sh
COPY ./ini.sh /var/www/

# 扩展安装
RUN apt-get update\
    && apt-get install -y zlib1g-dev libxml2-dev cron libfreetype6-dev libmcrypt-dev libjpeg-dev libpng-dev libzip-dev vim screen telnet net-tools\
    && docker-php-ext-configure gd --enable-gd-native-ttf --with-freetype-dir=/usr/include/freetype2 --with-png-dir=/usr/include --with-jpeg-dir=/usr/include \
    && docker-php-ext-install mysqli pdo_mysql zip soap gd pcntl
# sqlsrv扩展安装
RUN rm /bin/sh && ln -s /bin/bash /bin/sh \
    && apt install -y gnupg apt-transport-https \
    && curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && curl https://packages.microsoft.com/config/debian/9/prod.list > /etc/apt/sources.list.d/mssql-release.list \
    && apt-get update \
    && ACCEPT_EULA=Y apt-get install -y msodbcsql17 mssql-tools \
    && echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bash_profile \
    && echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc \
    && /bin/bash -c "source ~/.bashrc" \
    && apt-get install -y unixodbc-dev \
    && cd /usr/local \
    && a2enmod rewrite
    # && curl https://pecl.php.net/get/sqlsrv-5.5.0preview.tgz -o sqlsrv-5.5.0preview.tgz \
    # && pecl install sqlsrv-5.5.0preview.tgz \
    # && echo extension=sqlsrv.so >> /usr/local/etc/php/php.ini\
    # && pecl install pdo_sqlsrv-5.5.0preview.tgz \
    # && echo extension=pdo_sqlsrv.so >> /usr/local/etc/php/php.ini\
    # && pecl install -y redis-4.2.0.tgz \
    # && echo extension=redis.so >> /usr/local/etc/php/php.ini \
    # && a2enmod rewrite

# pecl装不上，下载后安装
# curl https://pecl.php.net/get/sqlsrv-5.5.0preview.tgz -o sqlsrv-5.5.0preview.tgz
# pecl install sqlsrv-5.5.0preview.tgz

# curl https://pecl.php.net/get/pdo_sqlsrv-5.5.0preview.tgz -o pdo_sqlsrv-5.5.0preview.tgz
# pecl install pdo_sqlsrv-5.5.0preview.tgz

# curl https://pecl.php.net/get/redis-4.2.0.tgz -o redis-4.2.0.tgz
# pecl install redis-4.2.0.tgz

# 开启重写    
# RUN a2enmod rewrite
ENTRYPOINT [ "/var/www/ini.sh"]
