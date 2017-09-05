$packageName = "MsSqlServerManagementStudio2014Express"
$chocolateyTempDir = Join-Path (Get-Item $env:TEMP).FullName "chocolatey"
$tempDir = Join-Path $chocolateyTempDir $packageName
$fileFullPath = "$tempDir\SQLManagementStudio.exe"
$extractPath = "$tempDir\SQLManagementStudio"
$setupPath = "$extractPath\setup.exe"
$silentArgs = "/IACCEPTSQLSERVERLICENSETERMS /FEATURES=Tools /Q /ACTION=uninstall"
$url = "https://download.microsoft.com/download/2/A/5/2A5260C3-4143-47D8-9823-E91BB0121F94/SQLManagementStudio_x86_ENU.exe"
$checksum = '8a3603ec1afe4320e4ad2685e194196584d79a7f2f5057ed4658913d6722e98a'
$url64 = "https://download.microsoft.com/download/2/A/5/2A5260C3-4143-47D8-9823-E91BB0121F94/SQLManagementStudio_x64_ENU.exe"
$checksum64 = 'b6451e433ae06b3bc6337b641e167a3b240eaf9ae2ae14449672f5f1ca7112fc'

# Using the same download location as Install-ChocolateyPackage but need to create the directory first
if (![System.IO.Directory]::Exists($tempDir)) { [System.IO.Directory]::CreateDirectory($tempDir) | Out-Null }
Get-ChocolateyWebFile $packageName $fileFullPath -Url $url -Url64bit $url64 -Checksum $checksum -Checksum64 $checksum64 -ChecksumType 'sha256'

Write-Host "Extracting..."
Start-Process "$fileFullPath" "/Q /x:`"$extractPath`"" -Wait

Write-Host "Uninstalling..."
Uninstall-ChocolateyPackage "$packageName" "EXE" "$silentArgs" "$setupPath" -validExitCodes @(0, 3010)

Write-Host "Removing extracted files..."
rm -r "$extractPath"
