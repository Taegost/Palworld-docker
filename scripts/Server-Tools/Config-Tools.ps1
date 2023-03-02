$defaultConfigDirectory='/app/default-configs/'

function Copy-Configs
{
  Copy-Item (Join-Path $defaultConfigDirectory ConfigFile1.ini) -Destination "/app/server/path/to/config/folder"
  Copy-Item (Join-Path $defaultConfigDirectory ConfigFile2.ini) -Destination "/app/server/path/to/config/folder"
  Copy-Item (Join-Path $defaultConfigDirectory ConfigFile3.ini) -Destination "/app/server/path/to/config/folder"
}