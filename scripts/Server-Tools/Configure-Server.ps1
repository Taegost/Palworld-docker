$configFolder = '/app/saves/pathtofolder'
$serverSettingsFile = "ServerSettings.ini"

function Configure-Server
{
    if (-not (Test-Path $configFolder))
    {
        Write-Output "Config folder doesn't exist, creating it now"
        New-Item $configFolder -ItemType Directory
    }
 
  $serverSettingsFilePath = Join-Path $configFolder $serverSettingsFile

  if (-Not (Test-Path $serverSettingsFilePath))
  {
    Write-Output "Server settings file doesn't exist, creating it now"
    New-Item $serverSettingsFilePath
  }
  
  # Change this section for the actual game. These are some examples.
  if (-Not ((Get-Content $serverSettingsFilePath) -match '[/Script/Icarus.DedicatedServerSettings]'))
  {
    Write-Output "Server settings file does not include DedicatedServerSettings section, creating it now"

    "[/Script/Icarus.DedicatedServerSettings]" | Out-File $serverSettingsFilePath -Append
    "SessionName=$env:SERVER_NAME" | Out-File $serverSettingsFilePath -Append
    "JoinPassword=$env:SERVER_PASSWORD" | Out-File $serverSettingsFilePath -Append
    "MaxPlayers=$env:MAX_PLAYERS" | Out-File $serverSettingsFilePath -Append
    "AdminPassword=$env:ADMIN_PASSWORD" | Out-File $serverSettingsFilePath -Append
  }
  else 
  {
    Write-Output "Updating server settings"
    sed -i "/SessionName=/c\SessionName=$env:SERVER_NAME" $serverSettingsFilePath
    sed -i "/JoinPassword=/c\JoinPassword=$env:SERVER_PASSWORD" $serverSettingsFilePath
    sed -i "/MaxPlayers=/c\MaxPlayers=$env:MAX_PLAYERS" $serverSettingsFilePath
    sed -i "/AdminPassword=/c\AdminPassword=$env:ADMIN_PASSWORD" $serverSettingsFilePath
  } # if (-Not ((Get-Content $serverSettingsFilePath) -match
} # function Configure-Server