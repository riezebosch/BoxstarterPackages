$packageName = "MsSqlServer2014Express"
$chocolateyTempDir = Join-Path (Get-Item $env:TEMP).FullName "chocolatey"
$tempDir = Join-Path $chocolateyTempDir $packageName
$fileFullPath = "$tempDir\SQLEXPR.exe"
$extractPath = "$tempDir\SQLEXPR"
$setupPath = "$extractPath\setup.exe"
$silentArgs = "/IACCEPTSQLSERVERLICENSETERMS /INSTANCENAME=SQLEXPRESS /ACTION=uninstall /FEATURES=SQL /Q"
$url = "https://download.microsoft.com/download/3/9/F/39F968FA-DEBB-4960-8F9E-0E7BB3035959/SQLEXPR_x86_ENU.exe"
$url64 = "https://download.microsoft.com/download/3/9/F/39F968FA-DEBB-4960-8F9E-0E7BB3035959/SQLEXPR_x64_ENU.exe"
$checksum = 'b5a5e640563485013bf7c11b3751dc15b1f46955141ce74b1c36758c20fb239e'
$checksum64 = 'e8d8330e3e7d6f9242e658315b99aace4aabb71ed14f3ec465e4450d66d255b6'

# Using the same download location as Install-ChocolateyPackage but need to create the directory first
if (![System.IO.Directory]::Exists($tempDir)) { [System.IO.Directory]::CreateDirectory($tempDir) | Out-Null }
Get-ChocolateyWebFile $packageName $fileFullPath $url $url64 -Checksum $checksum -Checksum64 $checksum64 -ChecksumType "sha256"

Write-Host "Extracting..."
Start-Process "$fileFullPath" "/Q /x:`"$extractPath`"" -Wait

Write-Host "Uninstalling..."
Uninstall-ChocolateyPackage "$packageName" "EXE" "$silentArgs" "$setupPath" -validExitCodes @(0, 3010)

Write-Host "Removing extracted files..."
rm -r "$extractPath"
