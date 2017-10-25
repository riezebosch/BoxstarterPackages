
$ErrorActionPreference = 'Stop';

$packageName= 'dotnetcore-sdk'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://download.microsoft.com/download/7/3/A/73A3E4DC-F019-47D1-9951-0453676E059B/dotnet-sdk-2.0.2-win-x86.exe'
$checksum   = '352bf30e7d4339803cc5ded8d75de72acd26db7aabcc335d6b0fa10fc26719f6f001ec17b7f5bd296057004d8a2bc8e9d34bf47c40e1511dab2668cf4dc1d75b'
$url64      = 'https://download.microsoft.com/download/7/3/A/73A3E4DC-F019-47D1-9951-0453676E059B/dotnet-sdk-2.0.2-win-x64.exe'
$checksum64 = '0b3682c4c7b3b81906d3f011d8a45e06ec2470721a21693ad8040502f201008161f1d4ad73e05763386272c50bfe90be4e2a660734096b4d52e4997bb618a80c'

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

















