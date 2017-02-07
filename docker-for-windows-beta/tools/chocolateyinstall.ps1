$version = "1.13.1.9961"
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

  checksum      = '1925B9AE114A24ABAB878558E56CC470F252AF5B9B96B05BA8B363299DED1E5A'
  checksumType  = 'sha256'
 
  silentArgs    = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
