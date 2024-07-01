$ErrorActionPreference = 'Stop';

$packageName= 'docker-desktop'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://desktop.docker.com/win/main/amd64/153621/Docker%20Desktop%20Installer.exe'
$checksum   = '371a8df70028a488b7b21a13ef670322d47ec73f65d8b0b06e4625e0035ddbe8'

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
