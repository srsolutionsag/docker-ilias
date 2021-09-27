ARG ILIAS_BASE_IMAGE

FROM sturai/ilias-base:${ILIAS_BASE_IMAGE}

ENV ILIAS_VERSION=7.3
ENV ILIAS_SHA1=3bd618ac8b64c0b76f7f357bcfb693c462891b6f

RUN curl -o ilias.tar.gz -SL https://github.com/ILIAS-eLearning/ILIAS/releases/download/v${ILIAS_VERSION}/ILIAS-${ILIAS_VERSION}.tar.gz \
    && echo "$ILIAS_SHA1 *ilias.tar.gz" | sha1sum -c - \
    && tar -xzf ilias.tar.gz --strip-components=1 \
    && chown -R root:root . && chown www-data:www-data . \
    && rm ilias.tar.gz
