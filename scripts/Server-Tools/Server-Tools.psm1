<#
.SYNOPSIS
Loads the module functions
#>

$files = (Get-ChildItem $PSScriptRoot -Filter *.ps1)
foreach ($file in $files)
{
  . $file.FullName
}