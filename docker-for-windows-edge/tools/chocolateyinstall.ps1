$ErrorActionPreference = 'Stop';

$packageName= 'docker-for-windows-edge'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://download.docker.com/win/edge/13125/Docker%20for%20Windows%20Installer.exe'
$checksum   = '5d5b2257f358aa0f37b26d1e290038be9486f4d693eddb953d9e0eea9c3b0ad4'

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
