$ErrorActionPreference = 'Stop';

$packageName = 'docker-desktop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64 = 'https://desktop.docker.com/win/main/amd64/233772/DockerDesktop.msi'
$checksum64 = '8f53857b905789d3487ab4cb41a458188f6bc1558f828678a551751d2d5e98fd'

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
