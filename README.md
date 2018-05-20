# iQuest Keyboards & Mice - Brașov - 2018
**Table of Contents**  
- [Description](#description)  
- [References](#references)   

<a name="description">Description</a>
--
This repo contains the resources to be used during "How to Control Service Startup Order in Docker Compose" presentation at the [Keyboards & Mice](https://www.iquestgroup.com/en/event/keyboards-mice-brasov-2018/) iQuest public event, which is scheduled to take place in Brașov on June 6th, 2018.

<a name="references">References</a>
--
* Docker
  * [Home](https://www.docker.com/)
  * [Documentation](https://docs.docker.com/)
  * [HEALTHCHECK](https://docs.docker.com/engine/reference/builder/#healthcheck) instruction
  * [Daemon socket option](https://docs.docker.com/engine/reference/commandline/dockerd/#examples)
  * [Understanding the Security Risks of Running Docker Containers: Don't Lose Your Sock(et)s](https://www.ctl.io/developers/blog/post/tutorial-understanding-the-security-risks-of-running-docker-containers)
  * [Multi-stage builds](https://docs.docker.com/develop/develop-images/multistage-build/)
* Docker Compose
  * [Documentation](https://docs.docker.com/compose/)
  * [Releases](https://github.com/docker/compose/releases)
  * [Compose file format reference](https://docs.docker.com/compose/compose-file/compose-versioning/#compose-file-format-references)
  * [Compatibility matrix](https://docs.docker.com/compose/compose-file/compose-versioning/#compatibility-matrix)
  * [Environment variables in Compose](https://docs.docker.com/compose/environment-variables/)
  * [Control startup order in Compose](https://docs.docker.com/compose/startup-order/)
  * [Compose file depends_on directive](https://docs.docker.com/compose/compose-file/#depends_on)
  * [Depends_on in version3](https://github.com/docker/compose/issues/4305#issuecomment-276527457)
  * [My blog post used as the basis of this presentation](https://crossprogramming.com/2018/05/13/controlling-service-startup-order-in-docker-compose.html)
* Docker Engine API
  * [Home](https://docs.docker.com/develop/sdk/)
  * [API version history](https://docs.docker.com/engine/api/version-history/)
* byrnedo/alpine-curl
  * [Docker image](https://hub.docker.com/r/byrnedo/alpine-curl/)
* curl
  * [Home](https://curl.haxx.se/)
  * [Documentation](https://curl.haxx.se/docs/manpage.html)
  * [unix-socket](https://curl.haxx.se/docs/manpage.html#--unix-socket) option
* jq
  * [Home](https://stedolan.github.io/jq/)
  * [Documentation](https://stedolan.github.io/jq/manual/)
  * [Playground](https://jqplay.org/)
* .NET Core
  * [Using .NET Core in Visual Studio Code](https://code.visualstudio.com/docs/other/dotnet)
  * PostgreSQL 
    * Docker image: https://hub.docker.com/_/postgres/
    * Client Docker image: https://hub.docker.com/r/jbergknoff/postgresql-client/
    * pg_isready: https://www.postgresql.org/docs/10/static/app-pg-isready.html
    * ADO.NET driver
      * Home: http://www.npgsql.org/index.html  
      * NuGet package: https://www.nuget.org/packages/Npgsql/3.2.7  
  * Run application and database
````powershell
docker-compose down --rmi local `
;docker-compose build `
;docker-compose up
````
* [The Complete Guide to Creating Symbolic Links (aka Symlinks) on Windows](https://www.howtogeek.com/howto/16226/complete-guide-to-symbolic-links-symlinks-on-windows-or-linux/)
  * Create a hard-link from /dotnet-core-with-docker/sources to /dotnet-core-with-docker/compose/service-healthy folder:
````powershell
 cd \dotnet-core-with-docker\compose\service-healthy
 cmd /c mklink /J .\sources .\..\..\sources
````
 * [PostgreSQL Docker image](https://hub.docker.com/_/postgres/)
