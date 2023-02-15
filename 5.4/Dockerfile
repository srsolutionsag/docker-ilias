ARG ILIAS_BASE_IMAGE

FROM srsolutions/ilias-base:${ILIAS_BASE_IMAGE}

ENV ILIAS_VERSION=5.4.26
ENV ILIAS_SHA1=0b0b70cbfc4c6d9fdef9cac4277c9f8a5dddc398

RUN curl -o ilias.tar.gz -SL https://github.com/ILIAS-eLearning/ILIAS/archive/v${ILIAS_VERSION}.tar.gz \
    && echo "$ILIAS_SHA1 *ilias.tar.gz" | sha1sum -c - \
    && tar -xzf ilias.tar.gz --strip-components=1 --no-same-owner \
    && rm ilias.tar.gz
