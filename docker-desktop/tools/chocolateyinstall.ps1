$ErrorActionPreference = 'Stop';

$packageName= 'docker-desktop'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://download.docker.com/win/edge/35318/Docker%20Desktop%20Installer.exe'
$checksum   = '17eb7a658245d95741f527fd11ef7e14b36efa8cc8a11abe8c0145b2ff86c3c0'

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
