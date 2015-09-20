$packageName = "MsSqlServerManagementStudio2014Express"
$chocolateyTempDir = Join-Path (Get-Item $env:TEMP).FullName "chocolatey"
$tempDir = Join-Path $chocolateyTempDir $packageName
$fileFullPath = "$tempDir\SQLManagementStudio.exe"
$extractPath = "$tempDir\SQLManagementStudio"
$setupPath = "$extractPath\setup.exe"
$silentArgs = "/IACCEPTSQLSERVERLICENSETERMS /Q /ACTION=install /UPDATEENABLED=FALSE"
$url = "http://care.dlservice.microsoft.com/dl/download/E/A/E/EAE6F7FC-767A-4038-A954-49B8B05D04EB/MgmtStudio%2032BIT/SQLManagementStudio_x86_ENU.exe"
$url64 = "http://care.dlservice.microsoft.com/dl/download/E/A/E/EAE6F7FC-767A-4038-A954-49B8B05D04EB/MgmtStudio%2064BIT/SQLManagementStudio_x64_ENU.exe"

# Using the same download location as Install-ChocolateyPackage but need to create the directory first
if (![System.IO.Directory]::Exists($tempDir)) { [System.IO.Directory]::CreateDirectory($tempDir) | Out-Null }
Get-ChocolateyWebFile $packageName $fileFullPath $url $url64
 
Write-Host "Extracting..."
Start-Process "$fileFullPath" "/Q /x:`"$extractPath`"" -Wait

Write-Host "Installing..."
Install-ChocolateyInstallPackage "$packageName" "EXE" "$silentArgs" "$setupPath" -validExitCodes @(0, 3010)

Write-Host "Removing extracted files..."
rm -r "$extractPath"