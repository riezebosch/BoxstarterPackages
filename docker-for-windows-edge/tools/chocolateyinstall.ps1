$ErrorActionPreference = 'Stop';

$packageName= 'docker-for-windows-edge'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://download.docker.com/win/edge/19101/Docker%20for%20Windows%20Installer.exe'
$checksum   = '98807528412b06d737cf8eb1e79e7f3a7773985c7d2e5ee20de3384bc9f8acf1'

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
