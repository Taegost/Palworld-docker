Import-Module /scripts/Server-Tools/Server-Tools.psm1 -Force
$serverLauncherPath=(Join-Path '/app/server' 'server.exe')

Start-Sleep 10 # Delay initial startup to give the updater time to start
$copyConfigs = $true

Write-Output "--------------------------------------------"
Write-Output "Starting server"
Write-Output "${Get-Date}"
Write-Output "--------------------------------------------"

While (RunServer)
{
  If (-Not (UpdateRunning))
  {
    if (Test-Path $serverLauncherPath)
    {
      $serverArgs=""
      
      # We only want to copy the configs the first time the container starts
      if ($copyConfigs)
      {
        Copy-Configs
        Configure-Server
        $copyConfigs = $false
      }

      Write-Output "--------------------------------------------"
      Write-Output "Starting server with the following arguments:"
      Write-Output "Server Name: $env:SERVER_NAME"
      Write-Output "Port: $env:SERVER_PORT"
      Write-Output "Query Port: $env:QUERY_PORT"
      Write-Output "Additional Arguments (if any): $serverArgs"

      & $serverLauncherPath $serverArgs
    } # if (Test-Path $serverLauncherPath)
        else
    {
      Write-Output "Unable to locate server executable: ${$serverLauncherPath}"
      StopServer
    }
  }
  else
  {
    Start-Sleep 5
  } # If (-Not (UpdateRunning)
} # While (RunServer)