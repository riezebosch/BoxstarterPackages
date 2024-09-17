$ErrorActionPreference = 'Stop';

$packageName= 'docker-desktop'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://desktop.docker.com/win/main/amd64/167172/Docker%20Desktop%20Installer.exe'
$checksum   = 'fb4f24872f6c0a75b6260ea369a3f0744a13d1e567f5e7f8fb76dffb701e31c2'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url

  softwareName  = 'docker*'

  checksum      = $checksum
  checksumType  = 'sha256'
 
  silentArgs    = "install --quiet"
  validExitCodes= @(0, 3010, 1641, 3) # 3 = InstallationUpToDate 
}

Install-ChocolateyPackage @packageArgs
