FROM alpine:3.9

LABEL maintainer="Storezhang<storezhang@gmail.com>"

ENV POLIPO_DATA="/polipo-data"

VOLUME ${POLIPO_DATA}
WORKDIR ${POLIPO_DATA}

COPY entrypoint.sh /entrypoint.sh
ADD ./polipo/polipo /usr/bin/polipo

RUN set -x \
    && echo 'https://mirrors.ustc.edu.cn/alpine/v3.9/main'>/etc/apk/repositories \
    && echo 'https://mirrors.ustc.edu.cn/alpine/v3.9/community'>>/etc/apk/repositories \
    && apk update \
    && apk upgrade \
    && apk add --no-cache tzdata \
    && cp /usr/share/zoneinfo/Asia/Chongqing /etc/localtime \
    && chmod +x /entrypoint.sh \
    && rm -rf /tmp/*

ENTRYPOINT ["/usr/bin/polipo", "-c"]
CMD ["/${POLIPO_DATA}/polipo/config"]
