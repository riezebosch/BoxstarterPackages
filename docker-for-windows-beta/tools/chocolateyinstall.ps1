$version = "1.13.0.9442"
$ErrorActionPreference = 'Stop';

$packageName= 'docker-for-windows-beta'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = "https://download.docker.com/win/beta/$version/InstallDocker.msi"

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'MSI'
  url           = $url
  url64bit      = $url64

  softwareName  = 'docker*'

  checksum      = '13f32466ed424fb94d6bfa7fb981b3f6fa3f4918ff922d2ac3191aedd977d69d'
  checksumType  = 'sha256'
 
  silentArgs    = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
