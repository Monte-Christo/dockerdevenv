# https://hub.docker.com/_/microsoft-dotnet-sdk/
# checkov:skip=CKV_DOCKER_2: Not needed here

FROM mcr.microsoft.com/dotnet/sdk:7.0

RUN useradd -s /bin/bash -m vscode
RUN groupadd docker && usermod -aG docker vscode

USER vscode

ENTRYPOINT ["sleep", "infinity"]