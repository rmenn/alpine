#!/bin/bash

ALPINE_ARCH=x86_64
ALPINE_VERSION=3.9.2
ALPINE_PARENT=$(echo $ALPINE_VERSION | cut -d '.' -f1,2)
ALPINE_FILENAME=alpine-minirootfs-${ALPINE_VERSION}-${ALPINE_ARCH}.tar.gz
echo ${ALPINE_PARENT}

BASE_URL=http://dl-cdn.alpinelinux.org/alpine/v${ALPINE_PARENT}/releases/${ALPINE_ARCH}
wget $BASE_URL/$ALPINE_FILENAME
docker build --build-arg ALPINE_VERSION=${ALPINE_VERSION} --build-arg ALPINE_ARCH=${ALPINE_ARCH} .
rm ${ALPINE_FILENAME}