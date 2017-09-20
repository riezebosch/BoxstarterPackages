$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageName= 'sharepoint'
$url        = 'https://download.microsoft.com/download/6/E/3/6E3A0B03-F782-4493-950B-B106A1854DE1/sharepoint.exe'
$checksum   = '5DCA0F664F1C397455288DA76AEFB5B98A3874CB4FB71AD1BA8AE59790249085'

$tempDir = Join-Path (Get-Item $env:TEMP).FullName "$packageName"
if ($env:packageVersion -ne $null) {$tempDir = Join-Path $tempDir "$env:packageVersion"; }

if (![System.IO.Directory]::Exists($tempDir)) { [System.IO.Directory]::CreateDirectory($tempDir) | Out-Null }
$fileFullPath = "$tempDir\sharepoint.exe"

Get-ChocolateyWebFile -PackageName $packageName -FileFullPath $fileFullPath -Url $url -Checksum $checksum -ChecksumType 'sha256'

Write-Host "Extracting..."
$extractPath = "$tempDir\sharepoint"
Start-Process "$fileFullPath" "/extract:`"$extractPath`" /quiet" -Wait

Write-Host "Prereq..."
Start-Process "$extractPath\prerequisiteinstaller.exe" "/unattended" -Wait

Write-Host "Installing..."
$setupPath = "$extractPath\setup.exe"
Install-ChocolateyInstallPackage $packageName "EXE" "/config $toolsDir\config.xml" $setupPath -validExitCodes @(0, 3010, 1116)

Write-Host "Removing extracted files..."
Remove-Item -Recurse "$extractPath"
