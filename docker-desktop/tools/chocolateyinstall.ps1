$ErrorActionPreference = 'Stop';

$packageName = 'docker-desktop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64 = 'https://desktop.docker.com/win/main/amd64/232925/DockerDesktop.msi'
$checksum64 = 'a8d748be100107e0ae625923575beb8831c535246f384060f961a8fb09e3eb56'

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  fileType       = 'MSI'
  url64bit       = $url64

  softwareName   = 'docker*'

  checksum64     = $checksum64
  checksumType64 = 'sha256'

  silentArgs     = "/quiet /norestart REMOVEEXISTINGINSTALL=1"
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
