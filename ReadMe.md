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

## Create config files

1. Dockerfile.dev

```Docker
# https://hub.docker.com/_/microsoft-dotnet-sdk/
FROM mcr.microsoft.com/dotnet/sdk:7.0

RUN useradd -s /bin/bash -m vscode
RUN groupadd docker && usermod -aG docker vscode

USER vscode
```

2. compose-dev.yaml

```YAML
services:
  app:
    build:
      context: .
      dockerfile: Dockerfile.dev
    entrypoint:
    - sleep
    - infinity
    init: true
    volumes:
    - type: bind
      source: /var/run/docker.sock
      target: /var/run/docker.sock
```

3. Commit and Sync

## Create Dev Env in Docker based on GitHub repo

Enter repo URL to build image

Run image in VS Code

```CLI
dotnet run
```
Install C# and Docker extensions

To work with the repo

```CLI
git config user.name "Edgar Knapp" 
git config user.email "edgar.r.knapp@hotmail.de"
```

To install recommended extensions upon container start, add file
` .vscode/extensions.json`

```JSON
 {
    "recommendations": ["ms-dotnettools.csharp", "ms-azuretools.vscode-docker"]
  }
  ```
Commit, sync, and try it out.

## Use a pre-built dev env image

Change config. Substitute block "build" with:

```YAML
    image: edgarknapp/net7dockerdevenv:latest
```

Commit and Sync

In the local instance of VS Code, create Image from Dockerfile

Push to DockerHub

Create new Docker dev env based on git repo

Run in VS Code

```CLI
dotnet run
```
