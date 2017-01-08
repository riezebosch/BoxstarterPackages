$version = "1.13.0.9606"
$ErrorActionPreference = 'Stop';

$packageName= 'docker-for-windows-beta'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = "https://download.docker.com/win/beta/$version/InstallDocker.msi"

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'MSI'
  url           = $url

  softwareName  = 'docker*'

  checksum      = '4df3a4d36a6f76fd2d490f29cecd0d05e09a34519b9ca3cb21f8e3d203ef57d0'
  checksumType  = 'sha256'
 
  silentArgs    = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
