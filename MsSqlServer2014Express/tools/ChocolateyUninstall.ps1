$scriptPath = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$exePath = "C:\VPC_Images\en_sql_server_2014_express_with_tools_x64`_exe_3941421.exe"
$extractPath = "$scriptPath\SQLEXPR"
$setupPath = "$extractPath\setup.exe"

Write-Host "Extracting..."
Start-Process "$exePath" "/Q /x:`"$extractPath`"" -Wait

Write-Host "Installing..."
& "$setupPath" /IACCEPTSQLSERVERLICENSETERMS /FEATURES=SQL,Tools /QS /ACTION=uninstall

Write-Host "Removing extracted files..."
rm -r "$extractPath"