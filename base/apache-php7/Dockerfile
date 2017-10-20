FROM php:7.0-apache

ENV ILIAS_WWW_PATH=/var/www/html
ENV ILIAS_DATA_PATH=/var/www/html/data
ENV ILIAS_ILIASDATA_PATH=/var/iliasdata/ilias

RUN apt-get update && apt-get install -y \
    curl \
    imagemagick \
    libav-tools \
    libpng12-dev \
    libxslt-dev \
    unzip \
    zip

RUN docker-php-ext-install \
    gd \
    mysqli \
    pdo \
    pdo_mysql \
    xsl

RUN a2enmod \
    expires \
    headers \
    rewrite

RUN mkdir -p ${ILIAS_ILIASDATA_PATH} \
    && chown www-data:www-data ${ILIAS_ILIASDATA_PATH}
VOLUME ${ILIAS_ILIASDATA_PATH}

RUN mkdir ${ILIAS_DATA_PATH} \
    && chown www-data:www-data ${ILIAS_DATA_PATH}
VOLUME ${ILIAS_DATA_PATH}

COPY docker-ilias-entrypoint /usr/local/bin/

ENTRYPOINT ["docker-ilias-entrypoint"]
CMD ["apache2-foreground"]
