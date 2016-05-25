$ErrorActionPreference = 'Stop';

$packageName= 'xmlspy'
$silentArgs = "/q /x"
$url        = 'http://cdn.sw.altova.com/v2016r2d/en/XMLSpyEnt2016rel2.exe'
$url64bit   = 'http://cdn.sw.altova.com/v2016r2d/en/XMLSpyEnt2016rel2_x64.exe'
$fileType   = "exe"

# Resolving the download location in the same way as Install-ChocolateyPackage: 
#   https://github.com/chocolatey/choco/blob/master/src/chocolatey.resources/helpers/functions/Install-ChocolateyPackage.ps1
$chocTempDir = $env:TEMP
$tempDir = Join-Path $chocTempDir "$packageName"
if ($env:packageVersion -ne $null) {$tempDir = Join-Path $tempDir "$env:packageVersion"; }

if (![System.IO.Directory]::Exists($tempDir)) { [System.IO.Directory]::CreateDirectory($tempDir) | Out-Null }
$file = Join-Path $tempDir "$($packageName)Install.$fileType"

$filePath = Get-ChocolateyWebFile $packageName $file $url $url64bit -checksum $checksum -checksumType $checksumType -checksum64 $checksum64 -checksumType64 $checksumType64 -options $options -getOriginalFileName

# Supporting chocolatey 0.9.9.x where the original/full path was not returned by Get-ChocolateyWebFile
if ($filePath -eq $null) { $filePath = $file }

Uninstall-ChocolateyPackage $packageName "EXE" $silentArgs $filePath -validExitCodes @(0, 3010)

















