FROM storezhang/alpine

LABEL maintainer="Storezhang<storezhang@gmail.com>"

ENV POLIPO_DATA="/polipo-data"

VOLUME ${POLIPO_DATA}
WORKDIR ${POLIPO_DATA}

ADD ./polipo/polipo /usr/bin/polipo

RUN set -x \
    && apk update \
    && apk upgrade \
    && apk add --no-cache tzdata \
    && cp /usr/share/zoneinfo/Asia/Chongqing /etc/localtime \
    && chmod +x /usr/bin/polipo \
    && rm -rf /tmp/*

ENTRYPOINT ["/usr/bin/polipo", "-c"]
CMD ["/polipo-data/config"]
