$ErrorActionPreference = 'Stop';

$packageName= 'docker-desktop'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://desktop.docker.com/win/main/amd64/69879/Docker%20Desktop%20Installer.exe'
$checksum   = 'fc17053b057aa688a38e84ca82b7b2738f7d5539b8fbf66b569356735dcf8cd7'

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
