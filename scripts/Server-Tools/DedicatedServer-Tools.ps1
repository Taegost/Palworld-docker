<#
.SYNOPSIS
Tools related to the running server
#>

[string]$serverProcessName=$env:SERVER_PROCESS_NAME

function ServerRunning
{
  return (Get-Process $serverProcessName -ErrorAction SilentlyContinue)
}

function KillServer
{
  $serverProcess=(ServerRunning)
  if ($serverProcess)
  {
    $serverProcess | Stop-Process -Force
  }
}