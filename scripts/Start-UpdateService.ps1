$backupLocation = '/app/backups'
$tempLocation = '/tmp/backups'
$serverLocation = '/app/server'

function RunSteamCMD()
{
  AddUpdateLock
  /steam/steamcmd.sh +force_install_dir "$serverLocation" +login anonymous +app_update $STEAM_APPID $UPDATES_STEAMCMD_ARGS +quit
  RemoveUpdateLock
}

function RunUpdate()
{
  return (($env:UPDATES_ENABLED) -or (-not (Test-Path /app/server/*)))
}

# ----------------- Main Section  -----------------

Import-Module /scripts/Server-Tools/Server-Tools.psm1 -Force
while (RunUpdate)
{
  RunSteamCMD
  Start-Sleep ($env:UPDATES_INTERVAL * 60)
} # while (RunUpdate)
