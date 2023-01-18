# Instructions

Important: Create project using all lowercase letters or else bad things will happen.

Caution: Carefully distinguish your local VS Code instance from your Docker
Dev Env instance. Also, port forwarding in the dev container may block the
port in the local VS Code instance.

## Create new Project

```CLI
mkdir dockerdevenvdemo
cd dockerdevenvdemo
dotnet new webapi
git init
dotnet new gitignore
code .
```

Commit changes, publish to GitHub.

Add an endpoint, make async, run, test, commit, and sync.

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

Add ReadMe.md, commit, and push

To work with the repo

```CLI
git config user.name "Edgar Knapp" 
git config user.email "edgar.r.knapp@hotmail.de"
```

Run the code

```CLI
dotnet run
```

Install C# and Docker extensions into the container manually. This gets old.

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

Run the app, if adding "swagger" gets old, add this to `launch.json`:

```JSON
    "pattern": "\\bNow listening on:\\s+http://\\S+:([0-9]+)",
    "uriFormat": "http://localhost:%s/swagger"
```

## Build and run a pre-built dev env image

In the *local* instance of VS Code:

Create a branch "pre-built".

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
