# pulled from https://stackoverflow.com/questions/48104954/adding-net-core-to-docker-container-with-jenkins
# Thanks to rockstar (Dockstar?) Dennis Fazekas
#  This will have jdk11 + maven + dotnet
#  This build name will be thanujtk/jenkins:lts-jdk11-dotnet-v[x] as defined in ../buildDeploy.Jenkinsfile
FROM thanujtk/jenkins:lts-jdk11
USER root

#wget  https://dot.net/v1/dotnet-install.sh && chmod +x dotnet-install.sh && ./dotnet-install.sh

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl libunwind8 gettext apt-transport-https && \
    curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg && \
    mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg && \
    sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-debian-stretch-prod stretch main" > /etc/apt/sources.list.d/dotnetdev.list' && \
    apt-get update

RUN apt-get install -y dotnet-sdk-3.1 && \
    export PATH=$PATH:$HOME/dotnet && \
    dotnet --version


USER jenkins