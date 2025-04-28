$ErrorActionPreference = 'Stop';

$packageName = 'docker-desktop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64 = 'https://desktop.docker.com/win/main/amd64/190950/Docker%20Desktop%20Installer.exe'
$checksum64 = '18712370bcbf833ac0db894158a72530268fe2a890216f5f96bee7b39b2b1233'

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
