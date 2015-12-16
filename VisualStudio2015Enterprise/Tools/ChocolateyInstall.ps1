$packageName = "VisualStudio2015Enterprise"
$params = "/passive /norestart /log $env:temp\vs.log"
$url = "http://download.microsoft.com/download/C/7/8/C789377D-7D49-4331-8728-6CED518956A0/vs_enterprise_ENU.exe"

$chocolateyTempDir = Join-Path $env:TEMP "chocolatey"
$tempDir = Join-Path $chocolateyTempDir $packageName
$fileFullPath = "$tempDir\vs_enterprise_ENU.exe"

if (![System.IO.Directory]::Exists($tempDir)) { [System.IO.Directory]::CreateDirectory($tempDir) | Out-Null }
Get-ChocolateyWebFile $packageName $fileFullPath $url

Write-Host "Parameters: $env:chocolateyPackageParameters"

if ($env:chocolateyPackageParameters -match "(?<=/layout )\S+") {
	$layout = $matches[0]
	
	# Create layout on specified location
	Write-Host "Creating layout at: $layout"
	Start-Process $fileFullPath "/layout $layout $params" -Wait
	
	# Redirect installation to layout folder
	$fileFullPath = Join-Path $layout "vs_enterprise.exe"
}

Install-ChocolateyInstallPackage $packageName "exe" $params $fileFullPath -validExitCodes @(0, 3010)