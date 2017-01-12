$version = "1.12.6.9655"
$ErrorActionPreference = 'Stop';

$packageName= 'docker-for-windows'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = "https://download.docker.com/win/stable/$version/InstallDocker.msi"

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'MSI'
  url           = $url

  softwareName  = 'docker*'

  checksum      = 'ff51ea25ebd8ae4e47363834330d5fa55f43453f8ca8f79872ec1422d299d984'
  checksumType  = 'sha256'
 
  silentArgs    = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
