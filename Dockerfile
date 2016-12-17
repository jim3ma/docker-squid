FROM alpine:3.4
MAINTAINER sameer@damagehead.com

ENV SQUID_VERSION=3.5.20-r0 \
    SQUID_CACHE_DIR=/var/spool/squid3 \
    SQUID_LOG_DIR=/var/log/squid \
    SQUID_USER=squid

RUN apk --no-cache add squid=${SQUID_VERSION} \
 && mv /etc/squid/squid.conf /etc/squid/squid.conf.dist

COPY squid.conf /etc/squid/squid.conf
COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh

EXPOSE 3128/tcp
VOLUME ["${SQUID_CACHE_DIR}"]
ENTRYPOINT ["/sbin/entrypoint.sh"]
