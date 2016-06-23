$packageName = "VisualStudio2015Enterprise"
$params = "/passive /norestart /log $env:temp\vs.log"
$url = "http://download.microsoft.com/download/4/c/3/4c3d2dc6-1cb5-4fbf-81b1-cb2c3f630415/vs_enterprise.exe"

$chocolateyTempDir = Join-Path $env:TEMP "chocolatey"
$tempDir = Join-Path $chocolateyTempDir $packageName
$fileFullPath = "$tempDir\vs_enterprise_ENU.exe"

Write-Host "Parameters: $env:chocolateyPackageParameters"

if (![System.IO.Directory]::Exists($tempDir)) { [System.IO.Directory]::CreateDirectory($tempDir) | Out-Null }
Get-ChocolateyWebFile $packageName $fileFullPath $url

if ($env:chocolateyPackageParameters -match "(?<=/layout )\S+") {
	$layout = $matches[0]
	if (!([System.IO.Path]::IsPathRooted($layout))) {
		# Join relative path to package temp folder
		$layout = Join-Path $tempDir $layout
	}

	$installer = Join-Path $layout "vs_enterprise.exe"
	if (!(Test-Path $installer)) {
		Write-Host "Layout directory specified but not found at $layout, installing from bootstrapper installer."
		Write-Host "To create the layout use command: Start-Process $fileFullPath `"/layout $layout $params`" -Wait"
	} else {
		# Redirect installation to layout folder
		Write-Host "Installing from layout location at: $layout."
		$fileFullPath = $installer
	}
}

Install-ChocolateyInstallPackage $packageName "exe" $params $fileFullPath -validExitCodes @(0, 3010)