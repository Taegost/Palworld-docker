if (-not ($BACKUPS_ENABLED)) { $BACKUPS_ENABLED = $true }
if (-not ($BACKUPS_MAX_AGE)) { $BACKUPS_MAX_AGE = 3 }
if (-not ($BACKUPS_MAX_COUNT)) { $BACKUPS_MAX_COUNT = 0 }
if (-not ($BACKUPS_INTERVAL)) { $BACKUPS_INTERVAL = 360 }

$backupLocation = '/app/backups'
$saveLocation = '/app/server'

function RunBackups()
{
  return ($BACKUPS_ENABLED)
}

While (RunBackups)
{
  if (Test-Path (Join-Path $saveLocation "*")
  {
    $backupFile = Join-Path $backupLocation "backup-$((Get-Date).tostring("yyyyMMdd_HHmmss")).zip"
    zip -r $backupFile $saveLocation
  } # if (Test-Path $saveLocation)
  Start-Sleep ($BACKUPS_INTERVAL * 60)
} # While (RunBackups)
