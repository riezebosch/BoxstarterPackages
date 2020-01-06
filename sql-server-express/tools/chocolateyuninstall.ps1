$ErrorActionPreference = 'Stop';

$packageName= 'sql-server-express'
$silentArgs = ""

$setupPath = (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft SQL Server SQL2019').UninstallString
Uninstall-ChocolateyPackage $packageName "EXE" $silentArgs $setupPath -validExitCodes @(0, 3010)
