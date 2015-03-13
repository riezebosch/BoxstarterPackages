. (Join-Path $(Split-Path -parent $MyInvocation.MyCommand.Definition) 'common.ps1')

$adminFile = (Join-Path $(Split-Path -parent $MyInvocation.MyCommand.Definition) 'AdminDeployment.xml')
$customArgs = $env:chocolateyInstallArguments
$env:chocolateyInstallArguments=""

$settings = Initialize-VS-Settings $customArgs $adminFile
$installerArgs = Get-VS-Installer-Args $settings.ProductKey

$packageName = "vs2013.4-ultimate-iso"
$chocolateyTempDir = Join-Path $env:TEMP "chocolatey"
$tempDir = Join-Path $chocolateyTempDir $packageName
$fileFullPath = "$tempDir\vs2013.4_ult_enu.iso"

if (![System.IO.Directory]::Exists($tempDir)) { [System.IO.Directory]::CreateDirectory($tempDir) | Out-Null }
Get-ChocolateyWebFile $packageName $fileFullPath http://download.microsoft.com/download/1/E/0/1E0AA8D0-F5D4-45A8-9CA6-D9DC8A54DE3E/vs2013.4_ult_enu.iso -Checksum "62C2F1500924E7B1402B6FCB9350AE9E0AF444F9" -ChecksumType "sha1"

Mount-DiskImage -ImagePath $fileFullPath
$driveLetter = (Get-DiskImage $fileFullPath | Get-Volume).DriveLetter
Install-ChocolateyInstallPackage $packageName "EXE" $installerArgs "${driveLetter}:\vs_ultimate.exe" -validExitCodes 0, 3010
#Dismount-DiskImage -ImagePath $iso
