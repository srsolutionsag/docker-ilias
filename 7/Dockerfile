ARG ILIAS_BASE_IMAGE

FROM srsolutions/ilias-base:${ILIAS_BASE_IMAGE}

ENV ILIAS_VERSION=7.19
ENV ILIAS_SHA1=eb6de45562842568b0e50c36caf191e0a15e951e

RUN curl -o ilias.tar.gz -SL https://github.com/ILIAS-eLearning/ILIAS/releases/download/v${ILIAS_VERSION}/ILIAS-${ILIAS_VERSION}.tar.gz \
    && echo "$ILIAS_SHA1 *ilias.tar.gz" | sha1sum -c - \
    && tar -xzf ilias.tar.gz --strip-components=1 --no-same-owner \
    && rm ilias.tar.gz
