# Instructions

Important: Create project using all lowercase letters or else bad things will happen.

Caution: Carefully distinguish your local VS Code instance from your Docker Dev Env instance.

## Create new Project

```
dotnet new dockerdevenvdemo
git init
dotnet new gitignore
code .
```

## Add files

1. Dockerfile
```
# https://hub.docker.com/_/microsoft-dotnet-sdk/
FROM mcr.microsoft.com/dotnet/sdk:7.0

RUN useradd -s /bin/bash -m vscode
RUN groupadd docker && usermod -aG docker vscode

USER vscode
```

2. compose-dev.yaml
```
services:
  app:
    entrypoint:
    - sleep
    - infinity
    image: edgarknapp/net7dockerdevenv:latest
    init: true
    volumes:
    - type: bind
      source: /var/run/docker.sock
      target: /var/run/docker.sock
```

3. Commit

4. Sync

## Create Dev Env in Docker based on GitHub repo

Run in VS Code
```
dotnet run
```

To work with the repo
```
git config user.name "Edgar Knapp" 
git config user.email "edgar.r.knapp@hotmail.de"
```

In the local instance of VS Code, create Image from Dockerfile

Push to DockerHub
