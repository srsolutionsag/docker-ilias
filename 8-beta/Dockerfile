ARG ILIAS_BASE_IMAGE

FROM srsolutions/ilias-base:${ILIAS_BASE_IMAGE}

ENV ILIAS_VERSION=8.0_beta1
ENV ILIAS_SHA1=5e324195c41a22846cca249415cbec3a1e24bcf1

# TODO: Revert to release archives once available
RUN curl -o ilias.tar.gz -SL https://github.com/ILIAS-eLearning/ILIAS/archive/v${ILIAS_VERSION}.tar.gz \
    && echo "$ILIAS_SHA1 *ilias.tar.gz" | sha1sum -c - \
    && tar -xzf ilias.tar.gz --strip-components=1 \
    && chown -R root:root . && chown www-data:www-data . \
    && rm ilias.tar.gz

RUN echo "memory_limit=300M" > ${PHP_INI_DIR}/conf.d/composer.ini \
    && composer install --no-dev -q \
    && rm ${PHP_INI_DIR}/conf.d/composer.ini
