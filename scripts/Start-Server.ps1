Import-Module /scripts/Server-Tools/Server-Tools.psm1 -Force
$serverLauncherPath=(Join-Path '/app/server' 'server.exe')

Start-Sleep 10 # Delay initial startup to give the updater time to start

While (RunServer)
{
  If (-Not (UpdateRunning)
  {
    if (Test-Path $serverLauncherPath)
    {
      $args=""
      Copy-Configs
      Configure-Server
      & $serverLauncherPath $args
    } # if (Test-Path $serverLauncherPath)
  }
  else
  {
    Start-Sleep 5
  } # If (-Not (UpdateRunning)
} # While (RunServer)