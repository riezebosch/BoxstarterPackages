
$ErrorActionPreference = 'Stop';


$packageName= 'dotnetcore-vs'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://download.microsoft.com/download/A/3/8/A38489F3-9777-41DD-83F8-2CBDFAB2520C/DotNetCore.1.0.0-VS2015Tools.Preview2.exe'
$url64      = ''

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'MSI'
  url           = $url
  url64bit      = $url64

  silentArgs    = "/install /passive /norestart"
  validExitCodes= @(0, 3010, 1641)

  softwareName  = 'dotnetcore-vs*'
  checksum      = ''
  checksumType  = 'md5'
  checksum64    = ''
  checksumType64= 'md5'
}

Install-ChocolateyPackage @packageArgs

















