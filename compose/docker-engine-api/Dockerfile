FROM microsoft/dotnet:2.1-sdk AS build

WORKDIR /app

COPY sources/ .

RUN dotnet restore \
    && dotnet build \
    && dotnet publish -c Release -o out

FROM microsoft/dotnet:2.1-runtime AS runtime

WORKDIR /app

COPY --from=build /app/out ./

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        jq=1.5+dfsg-1.3 \
     && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["dotnet", "dotnet-core-with-docker.dll"]