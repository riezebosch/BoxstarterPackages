
$ErrorActionPreference = 'Stop';


$packageName= 'dotnetcore-sdk'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://go.microsoft.com/fwlink/?LinkID=847102'
$url64      = 'https://go.microsoft.com/fwlink/?LinkID=847097'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  url64bit      = $url64

  silentArgs    = "/install /quiet /norestart /log `"$env:TEMP\$($packageName)\$($packageName).MsiInstall.log`""
  validExitCodes= @(0, 3010, 1641)

  softwareName  = 'dotnet-core*'
  checksum      = 'C49B7D709F3C505D469B6E0D39B906B2D852FBC2727AC1BD2B6F2E8CE37E51C9'
  checksumType  = 'sha256'
  checksum64    = 'B349CF09915C715CD77A66A9F8DCD0649179CBB15231B8698075E4C6F7417677'
}

Install-ChocolateyPackage @packageArgs

















