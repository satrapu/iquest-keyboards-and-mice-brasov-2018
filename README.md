# iQuest Keyboards & Mice - Brașov - 2018
**Table of Contents**  
- [Description](#description)  
- [Presentation Slides](#slides) 
- [References](#references)   
- [Running the Application](#run)  

<a name="description">Description</a>
--
This repo contains the resources used during "How to Control Service Startup Order in Docker Compose" presentation at the [Keyboards & Mice](https://www.iquestgroup.com/news/event/keyboards-mice-brasov-2018) iQuest public event, which took place in Brașov on June 6th, 2018.  

This presentation is based on [this article](https://crossprogramming.com/2018/05/13/controlling-service-startup-order-in-docker-compose.html), but while the latter shows a Java console application fetching data from a MySQL database, the former uses a .NET Core console application fetching data from a PostgreSQL database.  

<a name="slides">Presentation Slides</a>  
--
SlideShare: https://www.slideshare.net/satrapu/how-to-control-service-startup-order-in-docker-compose

<a name="references">References</a>  
--
* Docker
  * [Home](https://www.docker.com/)
  * [Documentation](https://docs.docker.com/)
  * [HEALTHCHECK](https://docs.docker.com/engine/reference/builder/#healthcheck) instruction
  * [Multi-stage builds](https://docs.docker.com/develop/develop-images/multistage-build/)
  * [Daemon socket option](https://docs.docker.com/engine/reference/commandline/dockerd/#examples)
  * [Understanding the Security Risks of Running Docker Containers: Don't Lose Your Sock(et)s](https://www.ctl.io/developers/blog/post/tutorial-understanding-the-security-risks-of-running-docker-containers)
* Docker Compose
  * [Home](https://github.com/docker/compose)
  * [Documentation](https://docs.docker.com/compose/)
  * [Compatibility matrix](https://docs.docker.com/compose/compose-file/compose-versioning/#compatibility-matrix)
  * [Compose file format reference](https://docs.docker.com/compose/compose-file/compose-versioning/#compose-file-format-references)
  * [Environment variables in Compose](https://docs.docker.com/compose/environment-variables/)
  * [Control startup order in Compose](https://docs.docker.com/compose/startup-order/)
  * [Compose file depends_on directive](https://docs.docker.com/compose/compose-file/#depends_on)
  * [Depends_on in version3](https://github.com/docker/compose/issues/4305#issuecomment-276527457)
  * [Docker-compose bind mount docker.sock not a valid Windows path](https://github.com/docker/for-win/issues/1829#issuecomment-376328022)
* Docker Engine API
  * [Home](https://docs.docker.com/develop/sdk/)
  * [API version history](https://docs.docker.com/engine/api/version-history/)
* curl
  * [Home](https://curl.haxx.se/)
  * [Documentation](https://curl.haxx.se/docs/manpage.html)
  * [unix-socket](https://curl.haxx.se/docs/manpage.html#--unix-socket) option
  * [Running curl from Docker](https://hub.docker.com/r/byrnedo/alpine-curl/)
* jq
  * [Home](https://stedolan.github.io/jq/)
  * [Documentation](https://stedolan.github.io/jq/manual/)
  * [Playground](https://jqplay.org/)
* .NET Core
  * [Home](https://github.com/dotnet/core)
  * [Documentation](https://docs.microsoft.com/en-us/dotnet/core/)
  * [Docker images](https://hub.docker.com/r/microsoft/dotnet/)
  * [Using .NET Core in Visual Studio Code](https://code.visualstudio.com/docs/other/dotnet)
  * PostgreSQL ADO\.NET driver
    * [Home](http://www.npgsql.org/index.html)
    * [Documentation](http://www.npgsql.org/doc/)
    * [NuGet package](https://www.nuget.org/packages/Npgsql/3.2.7)
* PostgreSQL 
  * [Home](https://www.postgresql.org/)
  * [Documentation](https://www.postgresql.org/docs/)
  * [Docker image](https://hub.docker.com/_/postgres/)
  * [Client Docker image](https://hub.docker.com/r/jbergknoff/postgresql-client/)
  * [pg_isready](https://www.postgresql.org/docs/10/static/app-pg-isready.html)
* Alpine Linux
  * [Home](https://alpinelinux.org/)
  * [Packages for v3.7, x64](https://pkgs.alpinelinux.org/packages?name=&branch=v3.7&repo=main&arch=x86_64)
* Symbolic links on Windows
  * [The Complete Guide to Creating Symbolic Links (aka Symlinks) on Windows](https://www.howtogeek.com/howto/16226/complete-guide-to-symbolic-links-symlinks-on-windows-or-linux/)
  * Create a hard-link from /dotnet-core-with-docker/sources to /dotnet-core-with-docker/compose/service-healthy folder:
  ````powershell
  # PowerShell
  cd .\dotnet-core-with-docker\compose\service-healthy
  cmd /c mklink /J .\sources .\..\..\sources
  ````
  
<a name="run">Running the  Application</a>  
--
* Clone this repo
````powershell
git clone https://github.com/satrapu/iquest-keyboards-and-mice-brasov-2018.git
cd ./iquest-keyboards-and-mice-brasov-2018
````
* Start services
  * Using depends_on, condition and service_healthy:
  ````powershell
  # Windows - PowerShell console run as admin
  cd .\compose\service-healthy `
  ;cmd /c mklink /J .\sources .\..\..\sources `
  ;docker-compose down --rmi local `
  ;docker-compose build `
  ;docker-compose up app
  ```` 

  ````bash
  # Linux - Bash
  cd ./compose/service-healthy \
  && mkdir ./sources && cp ../../sources/* sources \
  && docker-compose down --rmi local \
  && docker-compose build \
  && docker-compose up app
  ```` 

  * Using Docker Engine API
  ````powershell
  # Windows - PowerShell console run as admin
  cd .\compose\docker-engine-api `
  ;cmd /c mklink /J .\sources .\..\..\sources `
  ;$Env:COMPOSE_CONVERT_WINDOWS_PATHS=1 `
  ;docker-compose down --rmi local `
  ;docker-compose build `
  ;docker-compose up app
  ```` 

  ````bash
  # Linux - Bash
  cd ./compose/docker-engine-api \
  && mkdir ./sources && cp ../../sources/* sources \
  && docker-compose down --rmi local \
  && docker-compose build \
  && docker-compose up app
  ```` 

  * Using port checking++
  ````powershell
  # Windows - PowerShell console run as admin
  cd .\compose\port-checking++ `
  ;cmd /c mklink /J .\sources .\..\..\sources `
  ;docker-compose down --rmi local `
  ;docker-compose build `
  ;docker-compose up --exit-code-from check_db_connectivity check_db_connectivity `
  ;if ($LASTEXITCODE -eq 0) { docker-compose up app } `
  else { echo "ERROR: Failed to start service due to one of its dependencies!" }
  ```` 

  ````bash
  # Linux - Bash
  cd ./compose/port-checking++ \
  && mkdir ./sources && cp ../../sources/* sources \
  && docker-compose down --rmi local \
  && docker-compose build \
  && docker-compose up --exit-code-from check_db_connectivity check_db_connectivity \
  && if [ $? -eq 0 ]; then docker-compose up app; else echo 'ERROR: Failed to start service due to one of its dependencies!'; fi
  ```` 
