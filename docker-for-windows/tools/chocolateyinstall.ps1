$ErrorActionPreference = 'Stop';

$packageName= 'docker-for-windows'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://download.docker.com/win/stable/19507/Docker%20for%20Windows%20Installer.exe'
$checksum   = '4f48ab087db0162bb5bc6df08222a1b61aefcfe06296cfee1cfc02d483ad11bd'

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
