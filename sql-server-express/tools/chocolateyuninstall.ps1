$ErrorActionPreference = 'Stop';

$packageName= 'sql-server-express'
$silentArgs = "/IACCEPTSQLSERVERLICENSETERMS /FEATURES=SQL /Q /ACTION=uninstall"

$setupPath = (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft SQL Server SQLServer2016').UninstallString
Uninstall-ChocolateyPackage "$packageName" "EXE" "$silentArgs" "$setupPath" -validExitCodes @(0, 3010)