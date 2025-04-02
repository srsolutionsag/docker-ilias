ARG ILIAS_BASE_IMAGE

FROM srsolutions/ilias-base:${ILIAS_BASE_IMAGE}

ENV ILIAS_VERSION=8.19
ENV ILIAS_MD5=a789400fd5861b98734d6c2aa04ef8e8

RUN curl -o ilias.tar.gz -SL https://github.com/ILIAS-eLearning/ILIAS/releases/download/v${ILIAS_VERSION}/ILIAS-${ILIAS_VERSION}.tar.gz \
    && echo "$ILIAS_MD5 *ilias.tar.gz" | md5sum -c - \
    && tar -xzf ilias.tar.gz --strip-components=1 --no-same-owner \
    && rm ilias.tar.gz
