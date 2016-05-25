$ErrorActionPreference = 'Stop';

$packageName= 'xmlspy'
$packageVersion = '2016.2.0'

$chocolateyTempDir = Join-Path (Get-Item $env:TEMP).FullName "chocolatey"
$tempDir = Join-Path $chocolateyTempDir -ChildPath $packageName | Join-Path -ChildPath $packageVersion

$fileFullPath = Join-Path $tempDir "$($packageName)Install.EXE"

$silentArgs = "/q /x"
$url        = 'http://cdn.sw.altova.com/v2016r2d/en/XMLSpyEnt2016rel2.exe'
$url64      = 'http://cdn.sw.altova.com/v2016r2d/en/XMLSpyEnt2016rel2_x64.exe'

# Using the same download location as Install-ChocolateyPackage but need to create the directory first
if (![System.IO.Directory]::Exists($tempDir)) { [System.IO.Directory]::CreateDirectory($tempDir) | Out-Null }

Get-ChocolateyWebFile $packageName $fileFullPath $url $url64
Uninstall-ChocolateyPackage $packageName "EXE" $silentArgs $fileFullPath -validExitCodes @(0, 3010)

















