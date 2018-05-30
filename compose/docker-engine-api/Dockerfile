FROM microsoft/dotnet:2.1-sdk AS build

LABEL maintainer="Bogdan Marian <satrapu@users.noreply.github.com>"

WORKDIR /app

COPY sources/ .

RUN dotnet restore \
    && dotnet build \
    && dotnet publish -c Release -o out

FROM microsoft/dotnet:2.1-runtime AS runtime

LABEL maintainer="Bogdan Marian <satrapu@users.noreply.github.com>"

WORKDIR /app

COPY --from=build /app/out ./
COPY ./docker-entrypoint.sh /bin/docker-entrypoint.sh

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        jq=1.5+dfsg-1.3 \
     && rm -rf /var/lib/apt/lists/* \
     && chmod +x /bin/docker-entrypoint.sh

ENTRYPOINT ["sh", "/bin/docker-entrypoint.sh"]