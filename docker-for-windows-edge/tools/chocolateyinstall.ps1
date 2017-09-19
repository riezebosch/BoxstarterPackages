$ErrorActionPreference = 'Stop';

$packageName= 'docker-for-windows-edge'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://download.docker.com/win/edge/13333/Docker%20for%20Windows%20Installer.exe'
$checksum   = '54787a2923db389179f100bc91942bc66d0b2944f747e4f8cce1809c28817cd7'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url

  softwareName  = 'docker*'

  checksum      = $checksum
  checksumType  = 'sha256'
 
  silentArgs    = "install --quiet"
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
