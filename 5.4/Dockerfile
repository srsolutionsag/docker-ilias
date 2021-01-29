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
    && rm -rf /var/lib/apt/* /var/cache/apt/*

RUN docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ && \
    docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
    docker-php-ext-install \
    gd \
    ldap \
    mysqli \
    pdo \
    pdo_mysql \
    soap \
    xmlrpc \
    xsl \
    zip

RUN a2enmod \
    expires \
    headers \
    rewrite

ENV OPENSSL_CONF=/etc/ssl/
RUN curl -o phantomjs.tar.bz2 -SL https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2 \
    && tar -xjf phantomjs.tar.bz2 \
    && mv phantomjs-2.1.1-linux-x86_64/bin/phantomjs /usr/local/bin/phantomjs \
    && rm -r phantomjs-2.1.1-linux-x86_64 phantomjs.tar.bz2

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

ENV ILIAS_VERSION=5.4.20
ENV ILIAS_SHA1=e5b55d1e89002abc89091025aa771669efc02ac2

RUN curl -o ilias.tar.gz -SL https://github.com/ILIAS-eLearning/ILIAS/archive/v${ILIAS_VERSION}.tar.gz \
    && echo "$ILIAS_SHA1 *ilias.tar.gz" | sha1sum -c - \
    && tar -xzf ilias.tar.gz --strip-components=1 \
    && chown -R root:root * \
    && rm ilias.tar.gz

COPY docker-ilias-entrypoint /usr/local/bin/
COPY install-ilias /usr/local/bin/

ENTRYPOINT ["docker-ilias-entrypoint"]
CMD ["apache2-foreground"]
