ARG ILIAS_BASE_IMAGE

FROM sturai/ilias-base:${ILIAS_BASE_IMAGE}

ENV ILIAS_VERSION=5.4.24
ENV ILIAS_SHA1=2e6d35423d67a8d5c3446bb741b601c444bbb44a

RUN curl -o ilias.tar.gz -SL https://github.com/ILIAS-eLearning/ILIAS/archive/v${ILIAS_VERSION}.tar.gz \
    && echo "$ILIAS_SHA1 *ilias.tar.gz" | sha1sum -c - \
    && tar -xzf ilias.tar.gz --strip-components=1 \
    && chown -R root:root * \
    && rm ilias.tar.gz
