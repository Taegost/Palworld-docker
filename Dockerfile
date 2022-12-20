FROM phusion/baseimage:jammy-1.0.1

ENV DEBIAN_FRONTEND=noninteractive

# Download and register the Microsoft repository GPG keys
RUN apt-get update
RUN apt-get install -y wget apt-transport-https software-properties-common
RUN wget -q "https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/packages-microsoft-prod.deb"
RUN dpkg -i packages-microsoft-prod.deb

# Update and install misc packages
RUN apt-get update
RUN apt-get install --no-install-recommends --no-install-suggests -y \
    powershell lib32gcc-s1 curl ca-certificates locales supervisor

# Install SteamCMD
WORKDIR /app/steam
RUN wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz \
  && tar xvf steamcmd_linux.tar.gz

# Set up server folders
WORKDIR /app
RUN mkdir -p ./backups
RUN mkdir -p ./server
RUN mkdir -p ./logs

# Copy configs
COPY ./configs/supervisord.conf /etc


# Copy scripts
WORKDIR /scripts
COPY ./scripts/Entrypoint.ps1 .
COPY ./scripts/Start-Server.ps1 .
COPY ./scripts/Start-BackupService.ps1 .

# HEALTHCHECK CMD sv status ddns | grep run || exit 1
# RUN chmod 755 /etc/service/ddns/run

CMD pwsh /scripts/Entrypoint.ps1
