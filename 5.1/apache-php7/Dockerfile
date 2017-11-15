FROM registry.studer-raimann.ch/ilias/core/base:apache-php7

ENV ILIAS_VERSION=5.1.20
ENV ILIAS_SHA1=8402a8cead13110e39463037342234ff568050d4

RUN curl -o ilias.tar.gz -SL https://github.com/ILIAS-eLearning/ILIAS/archive/v${ILIAS_VERSION}.tar.gz \
    && echo "$ILIAS_SHA1 *ilias.tar.gz" | sha1sum -c - \
    && tar -xzf ilias.tar.gz --strip-components=1 \
    && rm ilias.tar.gz
