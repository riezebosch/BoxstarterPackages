
$ErrorActionPreference = 'Stop';


$packageName= 'dotnetcore-sdk'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://go.microsoft.com/fwlink/?linkid=843452'
$url64      = 'https://go.microsoft.com/fwlink/?linkid=843448'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  url64bit      = $url64

  silentArgs    = "/install /quiet /norestart /log `"$env:TEMP\$($packageName)\$($packageName).MsiInstall.log`""
  validExitCodes= @(0, 3010, 1641)

  softwareName  = 'dotnet-core*'
  checksum      = 'a174f4cd787732845d4a09fc715deeaeb7b8d58d8ee0e8f044a3e012be7c448e'
  checksumType  = 'sha256'
  checksum64    = '8f252094a8a572a10ab75e923ee5905748990d2ce4de3e5f065356d509dfef43'
}

Install-ChocolateyPackage @packageArgs

















