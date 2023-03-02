<#
.SYNOPSIS
Tools related to the server updater
#>
$lockFileName='UPDATER.lock'
$lockFilePath=(Join-Path $env:TEMP_FOLDER $lockFileName)
[int]$appId=$env:STEAM_APPID

function UpdateRunning
{
  Return Test-Path $lockFilePath
}

function AddUpdateLock
{
  touch $lockFilePath
}

function RemoveUpdateLock
{
  if (Test-Path $lockFilePath) { Remove-Item $lockFilePath }
}

function InstalledVersion
{
  Write-Output "Getting installed version"
  $manifestPath="/app/server/steamapps/appmanifest_$appId.acf"
  $regex='(buildid)"\s+"(\d+)'

  if (Test-Path $manifestPath)
  {
    $manifestContents = Get-Content "$manifestPath" -raw
    $manifestContents -match $regex
    return $matches[2]
  }
  else
  { return $False }
}

function LatestVersion
{
  Write-Output "Getting latest version"
  $regex='(branches)([\S\s]+)(public")[^"]*("buildid)"\s+"(\d+)'
  $appInfo=(/steam/steamcmd.sh +login anonymous +app_info_update 1 +app_info_print $APPID +quit)
  $appInfo -match $regex
  return $matches[2]
}