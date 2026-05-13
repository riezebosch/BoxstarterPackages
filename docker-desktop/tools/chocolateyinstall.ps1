$ErrorActionPreference = 'Stop';

$packageName = 'docker-desktop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64 = 'https://desktop.docker.com/win/main/amd64/226574/Docker%20Desktop%20Installer.exe'
$checksum64 = '13a71ca029faa34947ffbf881bef63caee8094e5392e75ba57e420c78aacdf6b'

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
