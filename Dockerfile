FROM arm64v8/ubuntu:20.04

ARG VERSION=0.1.18
ENV TUNNELTO_VERSION=${VERSION}

ENV DASHBOARD_PORT=8080

ADD https://packagecloud.io/betacotech/tunnelto/packages/anyfile/tunnelto_armhf.zip/download?distro_version_id=230 /tmp/tunnelto_armhf.zip

RUN apt-get update \
    && apt-get install --no-install-recommends -y \
        ca-certificates \
        tini \
    && apt-get install unzip \
    && apt-get install curl \
    && rm -rf /var/lib/apt/lists/* \
    && curl -s https://packagecloud.io/install/repositories/betacotech/tunnelto/script.anyfile.sh \
    && Y \
    && bash \
    #&& unzip /tmp/tunnelto_armhf.zip \
    #&& chmod 777 tunnelto_armhf \
    #&& mv tunnelto_armhf /bin/tunnelto \
    && rm /tmp/tunnelto_armhf.zip

COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["tunnelto"]

EXPOSE ${DASHBOARD_PORT}:${DASHBOARD_PORT}
