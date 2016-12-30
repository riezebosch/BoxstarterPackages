
$ErrorActionPreference = 'Stop';


$packageName= 'dotnetcore-sdk'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://go.microsoft.com/fwlink/?LinkID=834981'
$url64      = 'https://go.microsoft.com/fwlink/?LinkID=835014'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  url64bit      = $url64

  silentArgs    = "/install /quiet /norestart /log `"$env:TEMP\$($packageName)\$($packageName).MsiInstall.log`""
  validExitCodes= @(0, 3010, 1641)

  softwareName  = 'dotnet-core*'
  checksum      = '387C7FFB74E81EA62010C395237EBCC8D9F34666C8D38D44F5FFCB5A459AD148'
  checksumType  = 'sha256'
  checksum64    = '0C15A66958B1FA593129E5FFCFCD0558B756187EB4767B0B06F718D0AA6F4FCE'
}

Install-ChocolateyPackage @packageArgs

















