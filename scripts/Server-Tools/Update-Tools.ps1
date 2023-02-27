<#
.SYNOPSIS
Tools related to the server updater
#>
$lockFileName='UPDATER.lock'
$lockFilePath=(Join-Path $env:TEMP_FOLDER $lockFileName)

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
  Remove-Item $lockFilePath
}