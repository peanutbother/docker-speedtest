FROM alpine as git
RUN apk update && \
    apk add --update git && \
    git clone https://github.com/henrywhitaker3/Speedtest-Tracker /site && \
    rm -rf /site/.git

FROM linuxserver/nginx
LABEL maintainer=henrywhitaker3@outlook.com

ARG TARGETARCH

COPY rootfs/ /
COPY --from=git /site /site

RUN sed -i "s/__REPLACE_ARCH__/$TARGETARCH/" /etc/cont-init.d/50-speedtest

EXPOSE 80 443

VOLUME ["/config"]
