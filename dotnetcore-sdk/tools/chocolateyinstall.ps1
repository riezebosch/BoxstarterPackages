
$ErrorActionPreference = 'Stop';

$packageName= 'dotnetcore-sdk'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://download.microsoft.com/download/1/1/5/115B762D-2B41-4AF3-9A63-92D9680B9409/dotnet-sdk-2.1.4-win-x86.exe'
$checksum   = '57703986a5c7eea8ceee265ce206a047e85dec5c698ad570df74b68cbfed36026bf70aa454924ec94be4d37ff492c76716beb23e12ed98816e5cb8e25eeeff0b'
$url64      = 'https://download.microsoft.com/download/1/1/5/115B762D-2B41-4AF3-9A63-92D9680B9409/dotnet-sdk-2.1.4-win-x64.exe'
$checksum64 = '10309b343be6dc51b04d09ed97035ddaabe250685e1799fec8a0d3f7f34ea77dddc1d742544320c21bacfa4a2c27678d262540ecf2cd69dad354a8ad207f388d'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  url64bit      = $url64

  silentArgs    = "/install /quiet /norestart /log `"$env:TEMP\$($packageName)\$($packageName).MsiInstall.log`""
  validExitCodes= @(0, 3010, 1641)

  softwareName  = 'dotnet-core*'
  checksum      = $checksum
  checksumType  = 'SHA512'
  checksum64    = $checksum64
}

Install-ChocolateyPackage @packageArgs

















