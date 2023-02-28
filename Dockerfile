FROM phusion/baseimage:jammy-1.0.1

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN apt-get upgrade

# Download and register the Microsoft repository GPG keys
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

# Install mcRcon
WORKDIR /mcrcon
RUN curl -s https://api.github.com/repos/Tiiffi/mcrcon/releases/latest \
| grep "browser_download_url.*64.tar.gz" \
| cut -d : -f 2,3 \
| tr -d \" \
| wget -qi -
RUN tar -xvzf *64.tar.gz

# Set up server folders
WORKDIR /app
RUN mkdir -p ./backups
RUN mkdir -p ./server
RUN mkdir -p ./logs

# Copy configs
COPY ./configs/supervisord.conf /etc

# Copy scripts
WORKDIR /scripts
COPY ./scripts/ .

WORKDIR /tmp

# Set up server defaults
ENV STEAM_APPID="00000" \ 
    SERVER_PROCESS_NAME="notepad" \ 
    SERVER_PORT="1234" \ 
    SERVER_NAME="Default Server Name" \
    SERVER_PASSWORD="DefaultPassword" \
    TEMP_FOLDER="/tmp" \
    TZ="Etc/UTC" \
    FILE_UMASK="022" \
    BACKUPS_ENABLED="True" \
    BACKUPS_MAX_AGE=3 \
    BACKUPS_MAX_COUNT=0 \
    BACKUPS_INTERVAL=360 \
    UPDATES_ENABLED="True" \
    UPDATES_WHILE_USERS_CONNECTED="False" \
    UPDATES_INTERVAL=15 \
    RCON_PORT=25575 \
    RCON_PASSWORD="ChangeThisPasswordIfUsingRCON" \
    RCON_MAX_KARMA=60

# HEALTHCHECK CMD sv status ddns | grep run || exit 1

CMD pwsh /scripts/Entrypoint.ps1
