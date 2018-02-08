$ErrorActionPreference = 'Stop';

$packageName= 'docker-for-windows-edge'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://download.docker.com/win/edge/15732/Docker%20for%20Windows%20Installer.exe'
$checksum   = '2792d9966a9da2fb32934a2c5e20b8cc614cb72bd4d74981e6deac27c5720a84'

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
