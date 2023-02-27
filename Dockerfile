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
    powershell lib32gcc-s1 curl ca-certificates locales supervisor zip

# Install SteamCMD
WORKDIR /steam
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
COPY ./scripts/Start-UpdateService.ps1 .

# Set up server defaults
ENV STEAM_APPID="00000" \
    TZ="Etc/UTC" \
    FILE_UMASK="022" \
    PORT_GAME="7777" \
    BACKUPS_ENABLED="True" \
    BACKUPS_MAX_AGE=3 \
    BACKUPS_MAX_COUNT=0 \
    BACKUPS_INTERVAL=360 \
    UPDATES_ENABLED="True" \
    UPDATES_INTERVAL=15

# HEALTHCHECK CMD sv status ddns | grep run || exit 1

CMD pwsh /scripts/Entrypoint.ps1
