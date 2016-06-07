
$ErrorActionPreference = 'Stop';


$packageName= 'MsSqlServerManagementStudio2016Express'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://download.microsoft.com/download/E/D/3/ED3B06EC-E4B5-40B3-B861-996B710A540C/SSMS-Setup-ENU.exe'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  url64bit      = $url64

  silentArgs    = "/IACCEPTSQLSERVERLICENSETERMS /Q /ACTION=install /UPDATEENABLED=FALSE"
  validExitCodes= @(0, 3010, 1641)

  softwareName  = 'MsSqlServerManagementStudio2016Express*'
  checksum      = ''
  checksumType  = 'md5'
  checksum64    = ''
  checksumType64= 'md5'
}

Install-ChocolateyPackage @packageArgs

















