$ErrorActionPreference = 'Stop';

$packageName= 'docker-desktop'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://desktop.docker.com/win/main/amd64/68347/Docker%20Desktop%20Installer.exe'
$checksum   = '96a41ae081d98c171e4f50782237fb1b70b35b3032e442dfb9ab2f03a903086a'

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
