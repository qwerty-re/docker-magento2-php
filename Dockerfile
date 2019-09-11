FROM php:7.2.22-fpm-buster
LABEL maintainer="Mateusz Lerczak <mateusz@lerczak.eu>"

ARG MAGENTO_UID=1000
ARG MAGENTO_USERNAME="magento"
ARG MAGENTO_ROOT="/srv/magento2"
ARG PATH_IMAGICK_INI="/usr/local/etc/php/conf.d/imagick.ini"

ENV MAGERUN2_VERSION=3.2.0
ENV COMPOSER_VERSION=1.9.0
ENV CODE_SNIFFER_VERSION=3.4.2

ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/srv/magento2/bin
ENV PHP_USER ${MAGENTO_USERNAME}
ENV PHP_GROUP ${MAGENTO_USERNAME}
ENV PHP_PORT 9000
ENV PHP_PM dynamic
ENV PHP_PM_MAX_CHILDREN 5
ENV PHP_PM_START_SERVERS 2
ENV PHP_PM_MIN_SPARE_SERVERS 1
ENV PHP_PM_MAX_SPARE_SERVERS 3

RUN \
    useradd -u ${MAGENTO_UID} -ms /bin/bash ${MAGENTO_USERNAME} \
    && chown -R ${MAGENTO_USERNAME}:${MAGENTO_USERNAME} /srv

RUN apt update \
    && apt-get install -y gnupg2 supervisor msmtp libjpeg-dev libpng-dev libfreetype6-dev libicu-dev libxml2-dev libxslt1-dev imagemagick libmagickwand-dev cron

RUN \
    docker-php-ext-configure \
        gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install \
        bcmath \
        gd \
        intl \
        mbstring \
        hash \
        pdo_mysql \
        soap \
        xsl \
        zip \
        pcntl \
        opcache

COPY container /

RUN \
    pecl install imagick \
    && echo "extension=$(find /usr/local/lib/php/extensions/ -name imagick.so)" > ${PATH_IMAGICK_INI}

RUN \
    curl -L https://github.com/composer/composer/releases/download/${COMPOSER_VERSION}/composer.phar -o /usr/local/bin/composer \
    && curl -L https://github.com/squizlabs/PHP_CodeSniffer/releases/download/${CODE_SNIFFER_VERSION}/phpcs.phar -o /usr/local/bin/phpcs \
    && curl -L https://github.com/squizlabs/PHP_CodeSniffer/releases/download/{$CODE_SNIFFER_VERSION}/phpcbf.phar -o /usr/local/bin/phpcbf \
    && curl -L https://files.magerun.net/n98-magerun2-${MAGERUN2_VERSION}.phar -o /usr/local/bin/magerun2 \
    && chmod +x /usr/local/bin/composer /usr/local/bin/phpcs /usr/local/bin/phpcbf /usr/local/bin/magerun2

RUN \
    curl -L https://github.com/magento/magento-coding-standard/archive/v4.tar.gz -o /home/magento/magento-coding-standard.tar.gz \
    && tar -zxvf /home/magento/magento-coding-standard.tar.gz -C /home/magento \
    && phpcs --config-set installed_paths /home/magento/magento-coding-standard-4 \
    && phpcs --config-set default_standard Magento2

RUN \
    mkdir -p /var/log/supervisor \
    && apt-get -y clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /home/magento/magento-coding-standard.tar.gz

CMD ["/usr/bin/supervisord"]

WORKDIR ${MAGENTO_ROOT}
