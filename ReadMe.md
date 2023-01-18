# Instructions

Important: Create project using all lowercase letters or else bad things will happen.

Caution: Carefully distinguish your local VS Code instance from your Docker Dev Env instance.

## Create new Project

```CLI
dotnet new webapi
git init
dotnet new gitignore
code .

Commit changes, publish to GitHub.
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

3. Commit and Push to repo `dockerdevenvdemo`

## Create Dev Env in Docker based on GitHub repo

Create a new dev env based on repo.

Enter repo URL <https://github.com/Monte-Christo/dockerdevenvdemo.git> to build image and run dev env container.

Connect to image with VS Code.

```CLI
dotnet run
```

Install C# and Docker extensions manually.

To work with the repo

```CLI
git config user.name "Edgar Knapp" 
git config user.email "edgar.r.knapp@hotmail.de"
```

To get prompted install recommended extensions upon container start, add file
`.vscode/extensions.json`

```JSON
{
    "recommendations": ["ms-dotnettools.csharp", "ms-azuretools.vscode-docker"]
}
  ```

Commit, sync, and quit VS Code.

Remove the dev env, create a new one.

Connect to it with VS Code and be prompted to install extensions.

## Build and run a pre-built dev env image

In the *local* instance of VS Code:

Change dev env config. Substitute block "build" with:

```YAML
    image: edgarknapp/dockerdevenvdemo:latest
```

Commit and Sync

Create Image from Dockerfile (right-click and provide tag `edgarknapp/dockerdevenvdemo:latest`.

Push to DockerHub.

Create new Docker dev env based on git repo.

Run in VS Code

```CLI
dotnet run
```

## Share dev env with others

Have someone else check out your repo and run your Docker dev env.

Make changes, commit, and push on one machine.

kPull and check changes just made on the other.

## Run multiple containers

Switch to branch `oracle`.

Look at `compose-dev.yaml`.

Create new dev env using <https://github.com/Monte-Christo/dockerdevenvdemo.git@oracle>

Explore DB, open <http://localhost:5341>

## Other Things to Try

- Use other IDEs
