$packageName = "MsSqlServerManagementStudio2014Express"
$chocolateyTempDir = Join-Path (Get-Item $env:TEMP).FullName "chocolatey"
$tempDir = Join-Path $chocolateyTempDir $packageName
$fileFullPath = "$tempDir\SQLManagementStudio.exe"
$extractPath = "$tempDir\SQLManagementStudio"
$setupPath = "$extractPath\setup.exe"
$silentArgs = "/IACCEPTSQLSERVERLICENSETERMS /FEATURES=Tools /Q /ACTION=uninstall"
$url = "http://care.dlservice.microsoft.com/dl/download/E/A/E/EAE6F7FC-767A-4038-A954-49B8B05D04EB/MgmtStudio%2032BIT/SQLManagementStudio_x86_ENU.exe"
$checksum = '66ba5e061c08d60bbadd0ffad9847cbb67e7164a56ac9585d3594e7bf7456e80'
$url64 = "http://care.dlservice.microsoft.com/dl/download/E/A/E/EAE6F7FC-767A-4038-A954-49B8B05D04EB/MgmtStudio%2064BIT/SQLManagementStudio_x64_ENU.exe"
$checksum64 = 'fd9ab5f8c889c95e9eed341c08a1e0c8f353acc4fff57b89df0101cf4aa5f967'

# Using the same download location as Install-ChocolateyPackage but need to create the directory first
if (![System.IO.Directory]::Exists($tempDir)) { [System.IO.Directory]::CreateDirectory($tempDir) | Out-Null }
Get-ChocolateyWebFile $packageName $fileFullPath -Url $url -Url64bit $url64 -Checksum $checksum -Checksum64 $checksum64 -ChecksumType 'sha256'

Write-Host "Extracting..."
Start-Process "$fileFullPath" "/Q /x:`"$extractPath`"" -Wait

Write-Host "Uninstalling..."
Uninstall-ChocolateyPackage "$packageName" "EXE" "$silentArgs" "$setupPath" -validExitCodes @(0, 3010)

Write-Host "Removing extracted files..."
rm -r "$extractPath"
