
$ErrorActionPreference = 'Stop';

$packageName= 'dotnetcore-vs'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://download.microsoft.com/download/5/5/7/557D02A5-C3D0-4EF6-A570-4F75CD0DA5BF/DotNetCore.1.0.1-VS2015Tools.Preview2.0.2.exe'
$url64      = ''
$params     = '/install /quiet /norestart'
$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  url64bit      = $url64

  silentArgs    = $params
  validExitCodes= @(0, 3010, 1641)

  softwareName  = 'dotnetcore-vs*'
  checksum      = '1ae5796f397522a1be253b5fa45af3a5d771181fb28cebea6aba5530d04a5eb3'
  checksumType  = 'sha256'
  checksum64    = ''
  checksumType64= 'sha256'
}

$installed = $false
if ($env:chocolateyPackageParameters -match "(?<=/layout )\S+") {
	$layout = $matches[0]
	$fileFullPath = Join-Path $layout "DotNetCore.1.0.1-VS2015Tools.Preview2.0.2.exe"

	if (Test-Path $fileFullPath) {
		Write-Host "Installing from layout location at: $layout."
		Install-ChocolateyInstallPackage $packageName "exe" $params $fileFullPath -validExitCodes @(0, 3010)
    		$installed = $true
	}
  	else {
		Write-Host "Layout directory specified but installer not found at $fileFullPath, installing from bootstrapper installer."
	}
}

if (!$installed) {
  Install-ChocolateyPackage @packageArgs
}























