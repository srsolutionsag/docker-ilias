FROM php:7.0-apache

ARG ILIAS_VERSION
ENV ILIAS_VERSION=${ILIAS_VERSION}

ARG ILIAS_WWW_PATH=/var/www/html
ENV ILIAS_WWW_PATH=${ILIAS_WWW_PATH}

ARG ILIAS_DATA_PATH=/var/www/html/data
ENV ILIAS_DATA_PATH=${ILIAS_DATA_PATH}

ARG ILIAS_ILIASDATA_PATH=/var/iliasdata/ilias
ENV ILIAS_ILIASDATA_PATH=${ILIAS_ILIASDATA_PATH}

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

ADD https://github.com/ILIAS-eLearning/ILIAS/archive/v${ILIAS_VERSION}.tar.gz \
    ilias.tar.gz

RUN tar -xzf ilias.tar.gz --strip-components=1 \
    && rm ilias.tar.gz
