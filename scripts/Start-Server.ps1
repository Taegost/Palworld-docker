Import-Module /scripts/Server-Tools/Server-Tools.psm1 -Force

$count = 0
While ($true)
{
  If (-Not (UpdateRunning))
  {
    Write-Output "Update is not running"
  }
  # touch /app/server/$count
  Start-Sleep 3
  Write-Output "Main!"
  $count += 1
}