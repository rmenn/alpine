#!/bin/bash

ALPINE_VERSION=3.11.6

function download() {
ALPINE_ARCH=$1
DOCKER_ARCH=$2
ALPINE_PARENT=$(echo $ALPINE_VERSION | cut -d '.' -f1,2)
echo ${ALPINE_PARENT}
ALPINE_FILENAME=alpine-minirootfs-${ALPINE_VERSION}-${ALPINE_ARCH}.tar.gz
DOCKER_FILENAME=alpine-minirootfs-${ALPINE_VERSION}-${DOCKER_ARCH}.tar.gz
BASE_URL=http://dl-cdn.alpinelinux.org/alpine/v${ALPINE_PARENT}/releases/${ALPINE_ARCH}
wget $BASE_URL/$ALPINE_FILENAME
mv $ALPINE_FILENAME $DOCKER_FILENAME
}


download x86_64 amd64
download aarch64 arm64
DOCKER_CLI_EXPERIMENTAL=enabled docker buildx version
docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
docker buildx create --name builder --driver docker-container --driver-opt 'network=host' --buildkitd-flags '--allow-insecure-entitlement network.host' --use
docker buildx inspect --bootstrap
docker buildx build --progress=plain --build-arg=ALPINE_VERSION=${ALPINE_VERSION} --no-cache --platform linux/amd64,linux/arm64 -t rmenn/alpine:${ALPINE_VERSION} -f Dockerfile . --push
rm alpine-minirootfs-*
