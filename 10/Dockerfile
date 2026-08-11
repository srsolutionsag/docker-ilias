ARG ILIAS_BASE_IMAGE

FROM srsolutions/ilias-base:${ILIAS_BASE_IMAGE}

ENV ILIAS_VERSION=10.10
ENV ILIAS_MD5=2a3b2d979ba857db73452e4db3b9a3ac

RUN curl -o ilias.tar.gz -SL https://github.com/ILIAS-eLearning/ILIAS/releases/download/v${ILIAS_VERSION}/ILIAS-${ILIAS_VERSION}.tar.gz \
    && echo "$ILIAS_MD5 *ilias.tar.gz" | md5sum -c - \
    && tar -xzf ilias.tar.gz --strip-components=1 --no-same-owner \
    && rm ilias.tar.gz
