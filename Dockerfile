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

RUN sed 's/https:\/\/bintray.com\/ookla\/download\/download_file?file_path=ookla-speedtest-1.0.0-$arch-linux.tgz/https:\/\/install.speedtest.net\/app\/cli\/ookla-speedtest-1.1.1-linux-$arch.tgz/' /etc/cont-init.d/50-speedtest
RUN sed -i "s/__REPLACE_ARCH__/$TARGETARCH/" /etc/cont-init.d/50-speedtest

EXPOSE 80 443

VOLUME ["/config"]
