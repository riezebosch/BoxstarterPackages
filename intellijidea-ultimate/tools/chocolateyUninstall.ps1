$tools = Split-Path $MyInvocation.MyCommand.Definition

. $tools\uninstall.ps1

Uninstall-ChocolateyPackage `
  -PackageName 'intellijidea-ultimate' `
  -FileType 'EXE' `
  -Silent '/S' `
  -File (Get-Uninstaller -Name 'IntelliJ IDEA Ultimate Edition 2016.1.1')
