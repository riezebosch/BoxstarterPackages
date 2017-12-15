
$ErrorActionPreference = 'Stop';

$packageName= 'dotnetcore-sdk'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://download.microsoft.com/download/2/9/3/293BC432-348C-4D1C-B628-5AC8AB7FA162/dotnet-sdk-2.1.3-win-x86.exe'
$checksum   = '61e2ae2300a0489ab1a53feed31b5c11b14426bdd1120a2f8fa0ebe07e291b78452bb650983164a1056aa8ddff35d9ea256a7b3084052d548a116572db641676'
$url64      = 'https://download.microsoft.com/download/2/9/3/293BC432-348C-4D1C-B628-5AC8AB7FA162/dotnet-sdk-2.1.3-win-x64.exe'
$checksum64 = '8146bc0b74d152a9691e42d2c2f0755a735ed4cc48abeb79af86efea5801e8c7e94cf2f524c491c737cee45cf71c3182229f9a5201b9af8c5fcea324cfc67913'

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

















