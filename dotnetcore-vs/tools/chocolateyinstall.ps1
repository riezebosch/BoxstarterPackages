
$ErrorActionPreference = 'Stop';

$packageName= 'dotnetcore-vs'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://download.microsoft.com/download/F/6/E/F6ECBBCC-B02F-424E-8E03-D47E9FA631B7/DotNetCore.1.0.1-VS2015Tools.Preview2.0.3.exe'
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
  checksum      = '03CD219487C542E20116A6733833F6E6A83B317646763E2B6CA210C59DE924AD'
  checksumType  = 'sha256'
  checksum64    = '03CD219487C542E20116A6733833F6E6A83B317646763E2B6CA210C59DE924AD'
  checksumType64= 'sha256'
}

$installed = $false
if ($env:chocolateyPackageParameters -match "(?<=/layout )\S+") {
	$layout = $matches[0]
	$fileFullPath = Join-Path $layout "DotNetCore.1.0.1-VS2015Tools.Preview2.0.3.exe"

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























