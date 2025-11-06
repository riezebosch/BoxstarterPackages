$ErrorActionPreference = 'Stop';

$packageName = 'docker-desktop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64 = 'https://desktop.docker.com/win/main/amd64/209931/Docker%20Desktop%20Installer.exe'
$checksum64 = 'c92a3d363a4bfe1fca03fcd5484d4fb5e0f83aef1d39e7398bd5f921d63ab3a5'

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  fileType       = 'EXE'
  url64bit       = $url64

  softwareName   = 'docker*'

  checksum64     = $checksum64
  checksumType64 = 'sha256'

  silentArgs     = "install --quiet"
  validExitCodes = @(0, 3010, 1641, 3) # 3 = InstallationUpToDate 
}

Install-ChocolateyPackage @packageArgs
