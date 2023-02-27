Import-Module /scripts/Server-Tools/Server-Tools.psm1 -Force

While ($true)
{
  If (-Not (UpdateRunning))
  {
    Write-Output "Update is not running"
  }
  else
  {
    Write-Output "Update is running"
    Start-Sleep 30
  }
  # touch /app/server/$count
  Start-Sleep 5
}