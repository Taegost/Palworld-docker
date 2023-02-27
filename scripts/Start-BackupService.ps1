$backupLocation = '/app/backups'
$saveLocation = '/app/server'

function RunBackups()
{
  return ($env:BACKUPS_ENABLED)
}

While (RunBackups)
{
  if (Test-Path (Join-Path $saveLocation "*"))
  {
    $backupFile = Join-Path $backupLocation "backup-$((Get-Date).tostring("yyyyMMdd_HHmmss")).zip"
    zip -r $backupFile $saveLocation
  } # if (Test-Path $saveLocation)
  Start-Sleep ($env:BACKUPS_INTERVAL * 60)
} # While (RunBackups)
