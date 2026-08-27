$ErrorActionPreference = 'Stop';

$packageName = 'docker-desktop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64 = 'https://desktop.docker.com/win/main/amd64/237512/DockerDesktop.msi'
$checksum64 = '34abc68be6e090e3d3295b2156f229e42e558e5c4f26fba88dd718f2d90a1fa6'

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
