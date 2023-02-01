$backupLocation = '/app/backups'
$tempLocation = '/tmp/backups'
$serverLocation = '/app/server'

if (-not ($UPDATES_ENABLED)) { $UPDATES_ENABLED = $true }
if (-not ($UPDATES_INTERVAL)) { $UPDATES_INTERVAL = 15 }

function RunSteamCMD()
{
  /steam/steamcmd.sh +force_install_dir "$serverLocation" +login anonymous +app_update $STEAM_APPID $UPDATES_STEAMCMD_ARGS +quit
}

function RunUpdate()
{
  return (($UPDATES_ENABLED) -or (-not (Test-Path /app/server/*)))
}

# ----------------- Main Section  -----------------

while (RunUpdate)
{
  RunSteamCMD
  Start-Sleep ($UPDATES_INTERVAL * 60)
} # while (RunUpdate)
