FROM ubuntu:latest

ARG VERSION=0.1.18
ENV TUNNELTO_VERSION=${VERSION}

ENV DASHBOARD_PORT=8080

ADD https://github.com/agrinman/tunnelto/releases/download/${TUNNELTO_VERSION}/tunnelto-${TUNNELTO_VERSION}.big_sur.bottle.tar.gz /tmp/tunnelto.tar.gz

RUN apt-get update \
    && apt-get install --no-install-recommends -y \
        ca-certificates \
        tini \
    && rm -rf /var/lib/apt/lists/* \

    && tar -xf /tmp/tunnelto.tar.gz -C /${TUNNELTO_VERSION}/bin \
    && rm /tmp/tunnelto.tar.gz

COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["tunnelto"]

EXPOSE ${DASHBOARD_PORT}:${DASHBOARD_PORT}
