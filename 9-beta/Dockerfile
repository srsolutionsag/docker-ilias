ARG ILIAS_BASE_IMAGE

FROM srsolutions/ilias-base:${ILIAS_BASE_IMAGE}

ENV ILIAS_VERSION=9.0_beta3
ENV ILIAS_SHA1=bffefe43e573d0725e0d7c9a250952c598faf179

# TODO: Revert to release archives once available
RUN curl -o ilias.tar.gz -SL https://github.com/ILIAS-eLearning/ILIAS/archive/v${ILIAS_VERSION}.tar.gz \
    && echo "$ILIAS_SHA1 *ilias.tar.gz" | sha1sum -c - \
    && tar -xzf ilias.tar.gz --strip-components=1 \
    && chown -R root:root . && chown www-data:www-data . \
    && rm ilias.tar.gz

RUN curl -sS https://getcomposer.org/installer \
    | php -- --2 --install-dir=/usr/local/bin --filename=composer \
    && composer install --no-dev -q \
    && rm /usr/local/bin/composer
