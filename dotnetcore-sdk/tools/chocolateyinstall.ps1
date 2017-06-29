
$ErrorActionPreference = 'Stop';


$packageName= 'dotnetcore-sdk'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url      = 'https://download.microsoft.com/download/B/9/F/B9F1AF57-C14A-4670-9973-CDF47209B5BF/dotnet-dev-win-x86.1.0.4.exe'
$url64    = 'https://download.microsoft.com/download/B/9/F/B9F1AF57-C14A-4670-9973-CDF47209B5BF/dotnet-dev-win-x64.1.0.4.exe'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  url64bit      = $url64

  silentArgs    = "/install /quiet /norestart /log `"$env:TEMP\$($packageName)\$($packageName).MsiInstall.log`""
  validExitCodes= @(0, 3010, 1641)

  softwareName  = 'dotnet-core*'
  checksum      = '296da25ddeb15a3229f008b2b96d5909caec98bd456758f2f520e9b8c88426f2'
  checksumType  = 'sha256'
  checksum64    = 'a8b2a928e66eac6ccb939916d55d2d181b8f1433fc1fbf0d894713e8c86c7303'
}

Install-ChocolateyPackage @packageArgs

















