
$ErrorActionPreference = 'Stop';


$packageName= 'visualstudio2017-offline'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileLocation = "K:\VS2017\vs_setup.exe"

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  url64bit      = $url64
  file         = $fileLocation

  softwareName  = 'visualstudio2017-offline*'

  checksum      = ''
  checksumType  = 'md5'
  checksum64    = ''
  checksumType64= 'md5'

  silentArgs    = "--passive --norestart --wait"
  validExitCodes= @(0, 1, 3010, 1641)
}

Install-ChocolateyInstallPackage @packageArgs


















