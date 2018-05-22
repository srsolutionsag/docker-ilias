FROM php:7.0-apache

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
    zip \
    xsl

RUN a2enmod \
    expires \
    headers \
    rewrite

ENV ILIAS_WWW_PATH=/var/www/html
ENV ILIAS_DATA_PATH=/var/www/html/data
ENV ILIAS_ILIASDATA_PATH=/var/iliasdata/ilias

RUN mkdir -p ${ILIAS_ILIASDATA_PATH} \
    && chown www-data:www-data ${ILIAS_ILIASDATA_PATH}
VOLUME ${ILIAS_ILIASDATA_PATH}

RUN mkdir ${ILIAS_DATA_PATH} \
    && chown www-data:www-data ${ILIAS_DATA_PATH}
VOLUME ${ILIAS_DATA_PATH}

COPY docker-ilias-entrypoint /usr/local/bin/

ENTRYPOINT ["docker-ilias-entrypoint"]
CMD ["apache2-foreground"]

ARG ILIAS_MAX_UPLOAD_SIZE=200M

RUN echo "upload_max_filesize = ${ILIAS_MAX_UPLOAD_SIZE}\n\
post_max_size = ${ILIAS_MAX_UPLOAD_SIZE}" \
> /usr/local/etc/php/conf.d/ilias.ini

ENV ILIAS_VERSION=5.2.16
ENV ILIAS_SHA1=d1097430d3f6376e0e03d33e3ba9c70219c8167c

RUN curl -o ilias.tar.gz -SL https://github.com/ILIAS-eLearning/ILIAS/archive/v${ILIAS_VERSION}.tar.gz \
    && echo "$ILIAS_SHA1 *ilias.tar.gz" | sha1sum -c - \
    && tar -xzf ilias.tar.gz --strip-components=1 \
    && rm ilias.tar.gz
