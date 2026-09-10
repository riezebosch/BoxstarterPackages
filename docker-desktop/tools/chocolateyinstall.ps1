$ErrorActionPreference = 'Stop';

$packageName = 'docker-desktop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64 = 'https://desktop.docker.com/win/main/amd64/238679/DockerDesktop.msi'
$checksum64 = 'f6d6264acb914620fb8eb6234309fd9c0e83e1a4d1e816fae5dd5179fcd8cf75'

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
