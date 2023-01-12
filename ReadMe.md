# Instrauctions

Important: Create project using all lowercase letters or else bad things will happen

dotnet new dockerdevenvdemo
git init
dotnet new gitignore
code .

Add file Dockerfile.dev

    # https://hub.docker.com/_/microsoft-dotnet-sdk/
    FROM mcr.microsoft.com/dotnet/sdk:7.0

    RUN useradd -s /bin/bash -m vscode
    RUN groupadd docker && usermod -aG docker vscode

    USER vscode

    ENTRYPOINT ["sleep", "infinity"]

Commit
Sync

Create Dev Env in Docker based on GitHub repo
Run in VS Code
dotnet run

To work with the repo
git config user.name "Edgar Knapp" 
git config user.email "edgar.r.knapp@hotmail.de"
