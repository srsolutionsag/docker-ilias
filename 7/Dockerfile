ARG ILIAS_BASE_IMAGE

FROM srsolutions/ilias-base:${ILIAS_BASE_IMAGE}

ENV ILIAS_VERSION=7.30
ENV ILIAS_SHA1=9231ba032fb698167ac86406e1a552845ec5ab75

RUN curl -o ilias.tar.gz -SL https://github.com/ILIAS-eLearning/ILIAS/releases/download/v${ILIAS_VERSION}/ILIAS-${ILIAS_VERSION}.tar.gz \
    && echo "$ILIAS_SHA1 *ilias.tar.gz" | sha1sum -c - \
    && tar -xzf ilias.tar.gz --strip-components=1 --no-same-owner \
    && rm ilias.tar.gz
