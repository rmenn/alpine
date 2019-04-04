FROM scratch

ARG ALPINE_ARCH
ARG ALPINE_VERSION

ADD alpine-minirootfs-${ALPINE_VERSION}-${ALPINE_ARCH}.tar.gz /
CMD ["/bin/sh"]-
