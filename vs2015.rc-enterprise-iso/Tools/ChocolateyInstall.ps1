. (Join-Path $(Split-Path -parent $MyInvocation.MyCommand.Definition) 'common.ps1')

$adminFile = (Join-Path $(Split-Path -parent $MyInvocation.MyCommand.Definition) 'AdminDeployment.xml')
$customArgs = $env:chocolateyInstallArguments
$env:chocolateyInstallArguments=""

$settings = Initialize-VS-Settings $customArgs $adminFile
$installerArgs = Get-VS-Installer-Args $settings.ProductKey

$packageName = "vs2015.rc-enterprise-iso"
$chocolateyTempDir = Join-Path $env:TEMP "chocolatey"
$tempDir = Join-Path $chocolateyTempDir $packageName
$fileFullPath = "$tempDir\vs2015.rc_ent_enu.iso"

if (![System.IO.Directory]::Exists($tempDir)) { [System.IO.Directory]::CreateDirectory($tempDir) | Out-Null }
Get-ChocolateyWebFile $packageName $fileFullPath http://download.microsoft.com/download/C/A/A/CAA39018-05E5-49BA-8B24-4FC056EEA392/vs2015.rc_ent_enu.iso -Checksum "0596DF9E404E2F120815C37B39D3AA64B4189073" -ChecksumType "sha1"

Mount-DiskImage -ImagePath $fileFullPath
$driveLetter = (Get-DiskImage $fileFullPath | Get-Volume).DriveLetter
Install-ChocolateyInstallPackage $packageName "EXE" $installerArgs "${driveLetter}:\vs_enterprise.exe" -validExitCodes 0, 3010
#Dismount-DiskImage -ImagePath $iso
