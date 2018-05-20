FROM microsoft/dotnet:2.1-sdk AS build

WORKDIR /app

COPY sources/ .

RUN dotnet restore \
    && dotnet build \
    && dotnet publish -c Release -o out

FROM microsoft/dotnet:2.1-runtime AS runtime

WORKDIR /app

COPY --from=build /app/out ./

ENTRYPOINT ["dotnet", "dotnet-core-with-docker.dll"]