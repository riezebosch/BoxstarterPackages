
$ErrorActionPreference = 'Stop';

$packageName= 'dotnetcore-vs'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://download.microsoft.com/download/2/F/8/2F864C4E-6980-4AFC-B64E-0AC04837FD6C/DotNetCore.1.0.0-VS2015Tools.Preview2.0.1.exe'
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
  checksum      = 'C14673F6CE113116199549A7A6989C7F40FC31A4B3287E5921F2A40A0AC431D4'
  checksumType  = 'sha256'
  checksum64    = ''
  checksumType64= 'sha256'
}

$installed = $false
if ($env:chocolateyPackageParameters -match "(?<=/layout )\S+") {
	$layout = $matches[0]
	$fileFullPath = Join-Path $layout "DotNetCore.1.0.0-VS2015Tools.Preview2.exe"

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























