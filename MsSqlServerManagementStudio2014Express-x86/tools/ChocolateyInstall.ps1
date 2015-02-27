$scriptPath = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$exePath = "$scriptPath\SQLManagementStudio_x86_ENU.exe"
$extractPath = "$scriptPath\SQLManagementStudio_x86_ENU"
$setupPath = "$extractPath\setup.exe"
 
Get-ChocolateyWebFile 'SQLManagementStudioExpress2014-x86' "$exePath" http://care.dlservice.microsoft.com/dl/download/E/A/E/EAE6F7FC-767A-4038-A954-49B8B05D04EB/MgmtStudio%2032BIT/SQLManagementStudio_x86_ENU.exe
 
Write-Host "Extracting..."
Start-Process "$exePath" "/Q /x:`"$extractPath`"" -Wait

Write-Host "Installing..."
& "$setupPath" /IACCEPTSQLSERVERLICENSETERMS /Q /ACTION=install /UPDATEENABLED=FALSE

Write-Host "Removing extracted files..."
rm -r $extractPath