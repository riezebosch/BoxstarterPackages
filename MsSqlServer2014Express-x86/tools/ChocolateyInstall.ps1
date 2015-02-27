$scriptPath = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$exePath = "$scriptPath\SQLEXPR_x86_ENU.exe"
$extractPath = "$scriptPath\SQLEXPR_x86_ENU"
$setupPath = "$extractPath\setup.exe"

Get-ChocolateyWebFile 'SqlServerExpress2014-x86' "$exePath" http://care.dlservice.microsoft.com/dl/download/E/A/E/EAE6F7FC-767A-4038-A954-49B8B05D04EB/Express%2032BIT/SQLEXPR_x86_ENU.exe -validExitCodes @(0,-2067529716)

Write-Host "Extracting..."
Start-Process "$exePath" "/Q /x:`"$extractPath`"" -Wait

Write-Host "Installing..."
& "$setupPath" /IACCEPTSQLSERVERLICENSETERMS /Q /ACTION=install /INSTANCEID=SQLEXPRESS /INSTANCENAME=SQLEXPRESS /UPDATEENABLED=FALSE

Write-Host "Removing extracted files..."
rm -r "$extractPath"