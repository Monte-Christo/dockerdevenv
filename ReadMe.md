# Instructions

Important: Create project using all lowercase letters or else bad things will happen.

Caution: Carefully distinguish your local VS Code instance from your Docker Dev Env instance.

## Create new Project

```CLI
mkdir dockerdevenvdemo
cd dockerdevenvdemo
dotnet new webapi
git init
dotnet new gitignore
code .
```

Add some code:

```C#
static string Hi() => "Welcome to my Minimal API implementation!";

app.MapGet("/hello", Hi).WithName(nameof(Hi));

await app.RunAsync();
```

Run the code.

Commit and publish to public repo `dockerdevenvdemo`

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

3. Commit and Push.

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

To get prompted to install recommended extensions upon container start, add file
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

Create a new branch `pre-built`. Change dev env config. Substitute block "build" with:

```YAML
    image: edgarknapp/dockerdevenvdemo:latest
```

Commit and Sync

Right-click on Dockerfile and select `Create Image...`  (provide tag `edgarknapp/dockerdevenvdemo:latest`.

Use Docker Dashboard to push image to DockerHub.

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

Checkout `master`, create branch `oracle`. Publish branch.

Modify `compose-dev.yaml`. Append:

```YAML
  database:
    image: oracledocker.azurecr.io/oracle-19-e
    environment:
      - ORACLE_SID=ORCL19CDB
      - ORACLE_PDB=ORCL19PDB1
      - ORACLE_PWD=test123$$
      - ORACLE_CHARACTERSET=WE8MSWIN1252
    volumes:
      - ~/oracle/oradata:/opt/oracle/oradata  # persistent oracle database data
      - ~/oracle/data-bridge:/data-bridge     # share data with the running container
      - ~/oracle/scripts:/opt/oracle/scripts  # run setup and startup scripts
    ports:
      - 1521:1521
      - 5500:5500

  seq:
    image: datalust/seq
    environment:
      - ACCEPT_EULA=Y
    volumes:
      - seq-storage:/data
    ports:
      - 5341:80

volumes:
  seq-storage:
```

Commit and push.

Login to Azure and ACR.

```CLI
az login
az acr login --name oracledocker
```

Create new dev env using <https://github.com/Monte-Christo/dockerdevenvdemo.git@oracle>

Run app, explore DB in Bash CLI or SQL Developer, open <http://localhost:5341> for Seq,
inspect containers to check port assignments if connection fails.

## Other Things to Try

- Use other IDEs
- Set up existing Azure DevOps repos as Docker dev envs.
