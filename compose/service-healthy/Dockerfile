FROM microsoft/dotnet:2.1-sdk-alpine3.7 AS build

LABEL maintainer="Bogdan Marian <satrapu@users.noreply.github.com>"

WORKDIR /app

COPY sources/ .

RUN dotnet restore \
    && dotnet build \
    && dotnet publish -c Release -o out

FROM microsoft/dotnet:2.1-runtime-alpine3.7 AS runtime

WORKDIR /app

COPY --from=build /app/out ./

ENTRYPOINT ["dotnet", "dotnet-core-with-docker.dll"]