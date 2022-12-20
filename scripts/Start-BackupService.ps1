
if (-not ($BACKUPS_ENABLED)) { $BACKUPS_ENABLED = $true }
if (-not ($BACKUPS_MAX_AGE)) { $BACKUPS_MAX_AGE = 3 }
if (-not ($BACKUPS_MAX_COUNT)) { $BACKUPS_MAX_COUNT = 0 }

Write-Output "Enabled? $BACKUPS_ENABLED"
Write-Output "Age? $BACKUPS_MAX_AGE"
Write-Output "Max Count? $BACKUPS_MAX_COUNT"

$count = 0
While ($true)
{
  touch /app/backups/$count
  Start-Sleep 3
  Write-Output "Backup!"
  $count += 1
}
