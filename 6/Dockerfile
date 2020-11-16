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
    && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ && \
    case ${PHP_VERSION} in \
    7.4*) \
      docker-php-ext-configure gd --with-freetype --with-jpeg \
      ;; \
    *) \
      docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
      ;; \
    esac && \
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

ENV ILIAS_VERSION=6.5
ENV ILIAS_SHA1=c461e959cd6d72fbfd3fac3eb33e848b0ce0d8d4

RUN curl -o ilias.tar.gz -SL https://github.com/ILIAS-eLearning/ILIAS/releases/download/v${ILIAS_VERSION}/ILIAS-${ILIAS_VERSION}.tar.gz \
    && echo "$ILIAS_SHA1 *ilias.tar.gz" | sha1sum -c - \
    && tar -xzf ilias.tar.gz --strip-components=1 \
    && chown root:root * \
    && rm ilias.tar.gz

COPY docker-ilias-entrypoint-setup-cli /usr/local/bin/docker-ilias-entrypoint

ENTRYPOINT ["docker-ilias-entrypoint"]
CMD ["apache2-foreground"]
