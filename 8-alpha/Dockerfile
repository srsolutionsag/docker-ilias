ARG PHP_VERSION

FROM php:${PHP_VERSION}

RUN apt-get update && apt-get install -y --no-install-recommends \
        cron \
        curl \
        ghostscript \
        imagemagick \
        ffmpeg \
        libldap-dev \
        libpng-dev \
        libjpeg-dev \
        libfreetype6-dev \
        libxslt-dev \
        libzip-dev \
        mariadb-client \
        pwgen \
        unzip \
        zip \
        node-less \
        xfonts-75dpi \
        xfonts-base \
    && rm -rf /var/lib/apt/* /var/cache/apt/*

RUN docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install \
        gd \
        ldap \
        mysqli \
        pdo \
        pdo_mysql \
        soap \
        xsl \
        zip \
    && case ${PHP_VERSION} in \
    7.4*) \
      docker-php-ext-install xmlrpc \
      ;; \
    8.0*) \
      pecl install pecl install "channel://pecl.php.net/xmlrpc-1.0.0RC2" \
          && docker-php-ext-enable xmlrpc \
      ;; \
    esac

RUN a2enmod \
    expires \
    headers \
    rewrite

ENV WKHTMLTOX_VERSION=0.12.6-1
RUN curl -o wkhtmltox.deb -SL https://github.com/wkhtmltopdf/packaging/releases/download/${WKHTMLTOX_VERSION}/wkhtmltox_${WKHTMLTOX_VERSION}.buster_amd64.deb \
    && dpkg -i wkhtmltox.deb \
    && rm wkhtmltox.deb

RUN curl -sS https://getcomposer.org/installer \
    | php -- --version=1.10.17 --install-dir=/usr/local/bin --filename=composer

ENV ILIAS_WWW_PATH=/var/www/html
ENV ILIAS_DATA_PATH=/var/www/html/data
ENV ILIAS_ILIASDATA_PATH=/var/iliasdata/ilias

RUN mkdir -p ${ILIAS_ILIASDATA_PATH} \
    && chown www-data:root ${ILIAS_ILIASDATA_PATH} \
    && chmod 775 ${ILIAS_ILIASDATA_PATH}
VOLUME ${ILIAS_ILIASDATA_PATH}

RUN mkdir ${ILIAS_DATA_PATH} \
    && chown www-data:root ${ILIAS_DATA_PATH} \
    && chmod 775 ${ILIAS_DATA_PATH}
VOLUME ${ILIAS_DATA_PATH}

ENV ILIAS_VERSION=8.0_alpha
# TODO: Re-enable sha1 checksum test
ENV ILIAS_SHA1=

# TODO: Re-include ILIAS release (e.g. trunk)
#RUN curl -o ilias.tar.gz -SL https://github.com/ILIAS-eLearning/ILIAS/archive/refs/heads/${ILIAS_VERSION}.tar.gz \
#    && echo "$ILIAS_SHA1 *ilias.tar.gz" | sha1sum -c - \
#    && tar -xzf ilias.tar.gz --strip-components=1 \
#    && chown -R root:root . && chown www-data:www-data . \
#    && rm ilias.tar.gz
#
#RUN echo "memory_limit=300M" > ${PHP_INI_DIR}/conf.d/composer.ini \
#    && composer install --no-dev -q \
#    && rm ${PHP_INI_DIR}/conf.d/composer.ini

COPY docker-ilias-entrypoint-setup-cli /usr/local/bin/docker-ilias-entrypoint

ENTRYPOINT ["docker-ilias-entrypoint"]
CMD ["apache2-foreground"]
