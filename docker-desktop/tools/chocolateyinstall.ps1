$ErrorActionPreference = 'Stop';

$packageName = 'docker-desktop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64 = 'https://desktop.docker.com/win/main/amd64/236216/DockerDesktop.msi'
$checksum64 = 'b80a2e8d0b33b752b74f31c82019f62bb0335e6960722af934a7186a0e921682'

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
