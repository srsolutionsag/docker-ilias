ARG ILIAS_BASE_IMAGE

FROM srsolutions/ilias-base:${ILIAS_BASE_IMAGE}

ARG TARGETARCH
ARG NODE_VERSION=22.12.0

RUN case ${TARGETARCH} in amd64) NODE_ARCH=x64 ;; arm64) NODE_ARCH=arm64 ;; *) exit 1 ;; esac \
    && curl -o /tmp/node.tar.xz -SL https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-${NODE_ARCH}.tar.xz \
    && tar -xJf /tmp/node.tar.xz -C /opt --one-top-level --strip-components=1 --no-same-owner \
    && rm /tmp/node.tar.xz \
    && ln -s /opt/node/bin/node /usr/local/bin/node \
    && ln -s /opt/node/bin/npm /usr/local/bin/npm

ENV ILIAS_VERSION=10.0_beta3
ENV ILIAS_MD5=964b8ba83765dd3cd945d9d8598c21a3

# TODO: Revert to release archives once available
RUN curl -o ilias.tar.gz -SL https://github.com/ILIAS-eLearning/ILIAS/archive/v${ILIAS_VERSION}.tar.gz \
    && echo "$ILIAS_MD5 *ilias.tar.gz" | md5sum -c - \
    && tar -xzf ilias.tar.gz --strip-components=1 --no-same-owner \
    && npm clean-install --omit=dev --ignore-scripts \
    && composer install --no-dev -q \
    && rm ilias.tar.gz
