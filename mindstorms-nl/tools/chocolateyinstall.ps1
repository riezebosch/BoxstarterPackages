
$ErrorActionPreference = 'Stop';


$packageName= 'mindstorms-nl'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://esd.lego.com.edgesuite.net/digitaldelivery/mindstorms/6ecda7c2-1189-4816-b2dd-440e22d65814/public/LMS-EV3-WIN32-NL-01-02-01-full-setup.exe'
$url64      = ''

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  url64bit      = $url64

  softwareName  = 'mindstorms*'

  checksum      = '3B4759BF167DCFFE7A99B7D65557BBFA5656405394FFF05BFA5BDFE55DEE823B'
  checksumType  = 'sha256'
  checksum64    = ''
  checksumType64= 'md5'

  silentArgs    = "/q /acceptlicenses yes /r:n"
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs


















