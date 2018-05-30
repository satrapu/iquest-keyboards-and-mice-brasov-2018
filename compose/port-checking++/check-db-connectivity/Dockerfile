FROM alpine:3.7

LABEL maintainer="Bogdan Marian <satrapu@users.noreply.github.com>"

ENV PORT_CHECKING_SLEEP=""
ENV PORT_CHECKING_ATTEMPTS=""

ENV DB_HOST=""
ENV DB_NAME=""
ENV DB_PORT=""
ENV DB_USERNAME=""

COPY ./docker-entrypoint.sh /bin/docker-entrypoint.sh

RUN apk --update add \
        postgresql-client=10.4-r0 \
    && rm -rf /var/cache/apk/* \
    && chmod +x /bin/docker-entrypoint.sh

ENTRYPOINT ["sh", "/bin/docker-entrypoint.sh"]
