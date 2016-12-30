
$ErrorActionPreference = 'Stop';


$packageName= 'dotnetcore-sdk'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://go.microsoft.com/fwlink/?LinkID=836287'
$url64      = 'https://go.microsoft.com/fwlink/?LinkID=836281'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  url64bit      = $url64

  silentArgs    = "/install /quiet /norestart /log `"$env:TEMP\$($packageName)\$($packageName).MsiInstall.log`""
  validExitCodes= @(0, 3010, 1641)

  softwareName  = 'dotnet-core*'
  checksum      = '6BE9E4B34C168D65E51C9A4C05DCEBEF2CDE1FE07A1006A9777E427AB6D22D44'
  checksumType  = 'sha256'
  checksum64    = '60E4DDD00BF9620A00184D089C0ABAF118FF180A119FC1D5A1C512C4ACE41550'
}

Install-ChocolateyPackage @packageArgs

















