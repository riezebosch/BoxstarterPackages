
$ErrorActionPreference = 'Stop';

$packageName= 'dotnetcore-sdk'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://download.microsoft.com/download/D/7/2/D725E47F-A4F1-4285-8935-A91AE2FCC06A/dotnet-sdk-2.0.3-win-x86.exe'
$checksum   = '9933dbb2f52d3fe29e8825224e86016927d1fb791b0a5d36eea9efa5e30671e94a38497538c4dacb4059addcb100e89f803d2a8680d1c461128dd4efd4ff7161'
$url64      = 'https://download.microsoft.com/download/D/7/2/D725E47F-A4F1-4285-8935-A91AE2FCC06A/dotnet-sdk-2.0.3-win-x64.exe'
$checksum64 = '012f8530c2113c26c0205fe2d5497e6fec5823612b4249993eea20473a4d4cf5c35e1b2fd7133740981fdc8f23edc4caf315fb2b5a513429ad4ca77c7d11d619'

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

















