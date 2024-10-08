ARG HIBISCUS_VERSION=2.10.21 \
    HIBISCUS_DOWNLOAD_PATH=/opt/hibiscus-server.zip \
    HIBISCUS_INSTALL_PATH=/opt \
    HIBISCUS_SERVER_PATH=/opt/hibiscus-server

FROM alpine as base
ARG HIBISCUS_VERSION \
    HIBISCUS_DOWNLOAD_PATH \
    HIBISCUS_INSTALL_PATH \
    HIBISCUS_SERVER_PATH

ADD https://www.willuhn.de/products/hibiscus-server/releases/hibiscus-server-${HIBISCUS_VERSION}.zip $HIBISCUS_DOWNLOAD_PATH
RUN unzip $HIBISCUS_DOWNLOAD_PATH -d $HIBISCUS_INSTALL_PATH && rm ${HIBISCUS_DOWNLOAD_PATH}

FROM eclipse-temurin:23-jre-alpine as hibiscus-server
ARG HIBISCUS_VERSION \
    HIBISCUS_SERVER_PATH

COPY --chmod=775 --from=base $HIBISCUS_SERVER_PATH $HIBISCUS_SERVER_PATH
WORKDIR $HIBISCUS_SERVER_PATH

#/cfg/de.willuhn.jameica.hbci.rmi.HBCIDBService.properties
#/cfg/de.willuhn.jameica.webadmin.Plugin.properties

CMD ["./jameicaserver.sh", "-w /run/secrets/hibiscus-pwd"]
