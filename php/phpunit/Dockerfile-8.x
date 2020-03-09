# PHPUnit Docker Container.
FROM php:7.3-cli-alpine

MAINTAINER Tran Toan Van

ARG PHP_VERSION=7.3.0

ARG WORKDIRECTORY=/app

ARG HOST_USER_UID=1000
ARG HOST_USER_GID=1000
ARG HOST_USER_NAME=www
ARG HOST_GROUP_NAME=www

ENV PEAR_PACKAGES foo

WORKDIR /tmp

ADD https://raw.githubusercontent.com/php/php-src/php-${PHP_VERSION}/php.ini-production /usr/local/etc/php/php.ini

RUN echo 'BEGIN' \
    && set -xe \
    && apk --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing add \
            bash \
            ca-certificates \
            git \
            curl \
            unzip \
            php7-xml \
            php7-exif \
            php7-zip \
            php7-xmlreader \
            php7-zlib \
            php7-opcache \
            php7-mcrypt \
            php7-openssl \
            php7-curl \
            php7-json \
            php7-dom \
            php7-phar \
            php7-mbstring \
            php7-bcmath \
            php7-pdo \
            php7-pdo_pgsql \
            php7-pdo_sqlite \
            php7-pdo_mysql \
            php7-soap \
            php7-xdebug \
            php7-pcntl \
            php7-ctype \
            php7-session \
            php7-tokenizer \
            php7-xmlwriter \
            php7-intl \    
    && php -r "copy('https://pear.php.net/go-pear.phar', 'go-pear.phar');" \
    && php go-pear.phar \
    && php -r "unlink('go-pear.phar');" \
    && php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php --install-dir=/usr/bin --filename=composer \
    && php -r "unlink('composer-setup.php');" \    
    && composer --version \
    && curl https://phar.phpunit.de/phpunit-8.2.5.phar -o /usr/local/bin/phpunit \
    && chmod +x /usr/local/bin/phpunit \
	&& echo "Modify php.ini config" \    
	&& sed -e "s/^short_open_tag .*$/short_open_tag = Off/g" -i /usr/local/etc/php/php.ini \
	&& sed -e "s/^asp_tags .*$/asp_tags = Off/g" -i /usr/local/etc/php/php.ini \
	&& sed -e "s/^expose_php .*$/expose_php = Off/g" -i /usr/local/etc/php/php.ini \
	&& sed -e "s/^display_errors .*$/display_errors = Off/g" -i /usr/local/etc/php/php.ini \
	&& sed -e "s/^display_startup_errors .*$/display_startup_errors = Off/g" -i /usr/local/etc/php/php.ini \
	&& sed -e "s/^log_errors .*$/log_errors = On/g" -i /usr/local/etc/php/php.ini \
	&& sed -e "s/^memory_limit .*$/memory_limit = 150M/g" -i /usr/local/etc/php/php.ini \
	&& sed -e "s/^allow_url_fopen .*$/allow_url_fopen = Off/g" -i /usr/local/etc/php/php.ini \
	&& sed -e "s/^allow_url_include .*$/allow_url_include = Off/g" -i /usr/local/etc/php/php.ini \
	&& sed -e "s/^\;date\.timezone .*$/date\.timezone = \"Asia\/Ho_Chi_Minh\"/g" -i /usr/local/etc/php/php.ini \
	&& sed -e "s/^safe_mode .*$/safe_mode = Off/g" -i /usr/local/etc/php/php.ini \
	&& sed -e "s/^disable_functions .*$/disable_functions = proc_open, popen, disk_free_space, diskfreespace, leak, system, shell_exec, escapeshellcmd, proc_nice, dl, symlink, show_source/g" -i /usr/local/etc/php/php.ini \
	&& sed -e "s/^max_execution_time .*$/max_execution_time = 60/g" -i /usr/local/etc/php/php.ini \
	&& sed -e "s/^max_execution_time .*$/max_execution_time = 60/g" -i /usr/local/etc/php/php.ini \
	&& sed -e "s/^\;?opcache\.enable.*$/opcache.enable = 1/g" -i /usr/local/etc/php/php.ini \
	&& sed -e "s/^\;?opcache\.enable_cli.*$/opcache.enable_cli = 1/g" -i /usr/local/etc/php/php.ini \
	&& sed -e "s/^\;?opcache\.validate_timestamps.*$/opcache.validate_timestamps = 1/g" -i /usr/local/etc/php/php.ini \
	&& sed -e "s/^\;?opcache\.revalidate_freq.*$/opcache.revalidate_freq = 1/g" -i /usr/local/etc/php/php.ini \
    && phpunit --version \
    && composer --version 
    

ONBUILD RUN [ $PEAR_PACKAGES != "foo" ] && pear install $PEAR_PACKAGES

VOLUME ["${WORKDIRECTORY}"]

WORKDIR ${WORKDIRECTORY}

USER ${HOST_USER_NAME}

ENTRYPOINT ["/usr/local/bin/phpunit"]