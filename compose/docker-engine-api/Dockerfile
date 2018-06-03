FROM microsoft/dotnet:2.1-sdk-alpine3.7 AS build

LABEL maintainer="Bogdan Marian <satrapu@users.noreply.github.com>"

WORKDIR /app

COPY sources/ .

RUN dotnet restore \
    && dotnet build \
    && dotnet publish -c Release -o out

FROM microsoft/dotnet:2.1-runtime-alpine3.7 AS runtime

LABEL maintainer="Bogdan Marian <satrapu@users.noreply.github.com>"

WORKDIR /app

COPY --from=build /app/out ./
COPY ./docker-entrypoint.sh /bin/docker-entrypoint.sh

RUN apk --update add \
        curl=7.60.0-r1 \
        jq=1.5-r5 \
    && rm -rf /var/cache/apk/* \
    && chmod +x /bin/docker-entrypoint.sh

ENTRYPOINT ["sh", "/bin/docker-entrypoint.sh"]