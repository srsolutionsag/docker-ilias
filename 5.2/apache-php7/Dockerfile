FROM registry.studer-raimann.ch/ilias-elearning/ilias/base:apache-php7

ENV ILIAS_VERSION=5.2.8
ENV ILIAS_SHA1=4975e39275908202a0f3d54fe9e1febdf427cc75

RUN curl -o ilias.tar.gz -SL https://github.com/ILIAS-eLearning/ILIAS/archive/v${ILIAS_VERSION}.tar.gz \
    && echo "$ILIAS_SHA1 *ilias.tar.gz" | sha1sum -c - \
    && tar -xzf ilias.tar.gz --strip-components=1 \
    && rm ilias.tar.gz
