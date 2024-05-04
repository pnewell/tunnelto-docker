FROM ubuntu:latest

ARG VERSION=0.1.18
ENV TUNNELTO_VERSION=${VERSION}

ENV DASHBOARD_PORT=8080

ADD https://packagecloud.io/betacotech/tunnelto/packages/anyfile/tunnelto_armhf.zip/download?distro_version_id=230 /tmp/tunnelto_armhf.zip

RUN apt-get update \
    && apt-get install --no-install-recommends -y \
        ca-certificates \
        tini \
    && apt-get install unzip \
    && rm -rf /var/lib/apt/lists/* \
    #&& umask 000 \
    #&& apt install --reinstall coreutils \
    && unzip /tmp/tunnelto_armhf.zip \
    && mv /tmp/tunnelto_armhf /bin/tunnelto_armhf \
    && find /bin/tunnelto_armhf -type f -exec chmod 755 \
    #&& chmod 777 tunnelto_armhf \
    && rm /tmp/tunnelto_armhf.zip

COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["tunnelto_armhf"]

EXPOSE ${DASHBOARD_PORT}:${DASHBOARD_PORT}
