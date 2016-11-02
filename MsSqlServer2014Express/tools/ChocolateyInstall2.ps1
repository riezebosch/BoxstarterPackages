# Reference: https://github.com/riezebosch/BoxstarterPackages
$packageName = "MSSQLServer2014Express"
$executionPath = Split-Path -parent $MyInvocation.MyCommand.Definition
$chocolateyTempDir = Join-Path (Get-Item $env:TEMP).FullName "chocolatey"
$tempDir = Join-Path $chocolateyTempDir $packageName
$fileFullPath = "$tempDir\SQLEXPR.exe"
$extractPath = "$tempDir\SQLEXPR"
$setupPath = "$extractPath\setup.exe"
$url = "https://download.microsoft.com/download/1/5/6/156992E6-F7C7-4E55-833D-249BD2348138/ENU/x86/SQLEXPR_x86_ENU.exe"
$url64 = "https://download.microsoft.com/download/1/5/6/156992E6-F7C7-4E55-833D-249BD2348138/ENU/x64/SQLEXPR_x64_ENU.exe"
$checksum = '33C0112905B62B6BAD883112C2F49B50AA12C679'
$checksum64 = '0C90C147A1C2A550165C9301AE7A6C604E318E51'

# SQL Server Parameters - https://msdn.microsoft.com/en-us/library/ms144259.aspx
# How to Create the Configuration INI - https://msdn.microsoft.com/en-us/library/dd239405.aspx
$sqlServerConfigurationFile = Join-Path $executionPath "Configuration.ini"
$sqlServerConfigurationFilePath = Join-Path $tempDir $sqlServerConfigurationFile
$silentArgs = "/IAcceptSQLServerLicenseTerms /ConfigurationFile=""$($sqlServerConfigurationFilePath)"" /SAPWD=""SetYourOwn"""

# Copy the configuraiton file to the same palce as the setup
Copy-Item $sqlServerConfigurationFile $tempDir

# Create the package temporary directory
New-Item -ItemType Directory -Force -Path $tempDir

# Download the installer
Get-ChocolateyWebFile $packageName $fileFullPath $url $url64 -Checksum $checksum -Checksum64 $checksum64 -ChecksumType "sha1"

Write-Host "Extracting SQL Server Express Package..."
Start-Process "$fileFullPath" "/Q /x:`"$extractPath`"" -Wait

Write-Host "Installing SQL Server Express..."
Install-ChocolateyInstallPackage "$packageName" "EXE" "$silentArgs" "$setupPath" -validExitCodes @(0, 3010)

Write-Host "Removing SQL Server Express Extracted Files..."
rm -r "$extractPath"