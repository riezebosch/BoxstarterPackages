$scriptPath = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$exePath = "$scriptPath\SQLEXPR_x64_ENU.exe"
$extractPath = "$scriptPath\SQLEXPR_x64_ENU"
$setupPath = "$extractPath\setup.exe"

Write-Host "Extracting..."
Start-Process "$exePath" "/Q /x:`"$extractPath`"" -Wait

Write-Host "Installing..."
& "$setupPath" /IACCEPTSQLSERVERLICENSETERMS /FEATURES=SQL /QS /ACTION=uninstall

Write-Host "Removing extracted files..."
rm -r "$extractPath"