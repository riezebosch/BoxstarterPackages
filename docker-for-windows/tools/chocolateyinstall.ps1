$ErrorActionPreference = 'Stop';

$packageName= 'docker-for-windows'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://download.docker.com/win/stable/13529/Docker%20for%20Windows%20Installer.exe'
$checksum   = '389c378e064ee8d7782e096c137b4287ec544ac99ea0d14cc2bd0685059f7641'

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
