$count = 0
While ($true)
{
  touch /app/server/$count
  Start-Sleep 3
  Write-Output "Main!"
  $count += 1
}