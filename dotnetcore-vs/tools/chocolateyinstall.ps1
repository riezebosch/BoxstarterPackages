
$ErrorActionPreference = 'Stop';

$packageName= 'dotnetcore-vs'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://download.microsoft.com/download/A/3/8/A38489F3-9777-41DD-83F8-2CBDFAB2520C/DotNetCore.1.0.0-VS2015Tools.Preview2.exe'
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
  checksum      = ''
  checksumType  = 'md5'
  checksum64    = ''
  checksumType64= 'md5'
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























