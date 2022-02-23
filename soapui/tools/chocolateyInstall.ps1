$ErrorActionPreference = 'Stop';
$Version = "5.7.0"
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = "http://dl.eviware.com/soapuios/$Version/SoapUI-x32-$Version.exe"
$url64      = "http://dl.eviware.com/soapuios/$Version/SoapUI-x64-$Version.exe"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  url64bit      = $url64

  softwareName  = 'soapui*'

  checksum      = '6f32e0f5415e759afcd88bbd19786d16263a36584d38373a54650298e53f84a0'
  checksumType  = 'sha256'
  checksum64    = '86B6E5658886A0876D0196394F91A470E1AF7D62D3067EEB94C1F8C5293D3B18'
  checksumType64= 'sha256'

  silentArgs    = "-q"
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
