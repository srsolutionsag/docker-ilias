#!/bin/bash

IMAGE=sturai/ilias

build_ilias() {
    ilias_version=$1
    base=$2

    docker build --rm \
        -t ${IMAGE}:${ilias_version:0:3} \
        -t ${IMAGE}:${ilias_version} \
        -t ${IMAGE}:${ilias_version}-${base} \
        ${ilias_version:0:3}/${base}
}

for d in */*; do
    version=$(grep "ENV ILIAS_VERSION" $d/Dockerfile | awk -F "=" '{print $2}')
    base=$(basename $d)
    build_ilias $version $base
done

docker tag ${IMAGE}:$version ${IMAGE}:latest
