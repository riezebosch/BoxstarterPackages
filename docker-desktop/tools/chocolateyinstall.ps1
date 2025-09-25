$ErrorActionPreference = 'Stop';

$packageName = 'docker-desktop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64 = 'https://desktop.docker.com/win/main/amd64/206054/Docker%20Desktop%20Installer.exe'
$checksum64 = '79180a3a10d5ecfe5f8875c1a9429fd57b426ea7fb8e9c87099300f0b8ffd7a5'

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
