$ErrorActionPreference = 'Stop';

$packageName= 'sql-server-express-adv'
$url        = ''
$url64      = 'https://download.microsoft.com/download/7/c/1/7c14e92e-bdcb-4f89-b7cf-93543e7112d1/SQLEXPRADV_x64_ENU.exe'
$checksum   = '3BF3C226D2EBE9AEF3627E0E73A3A10903CFDEE49596D48A81FB80D495B2F72668E097C08F755599EE4F258D283CC97E0EB5E9701F3B092A6D2FFCB094543DA5'
$silentArgs = "/IACCEPTSQLSERVERLICENSETERMS /Q /ACTION=install /INSTANCEID=SQLEXPRESS /INSTANCENAME=SQLEXPRESS /UPDATEENABLED=FALSE"

$tempDir = Join-Path (Get-Item $env:TEMP).FullName "$packageName"
if ($env:packageVersion -ne $null) {$tempDir = Join-Path $tempDir "$env:packageVersion"; }

if (![System.IO.Directory]::Exists($tempDir)) { [System.IO.Directory]::CreateDirectory($tempDir) | Out-Null }
$fileFullPath = "$tempDir\SQLEXPR.exe"

Get-ChocolateyWebFile -PackageName $packageName -FileFullPath $fileFullPath -Url $url -Url64bit $url64 -Checksum $checksum -ChecksumType 'sha512'

Write-Host "Extracting..."
$extractPath = "$tempDir\SQLEXPR"
Start-Process "$fileFullPath" "/Q /x:`"$extractPath`"" -Wait

Write-Host "Installing..."
$setupPath = "$extractPath\setup.exe"
Install-ChocolateyInstallPackage "$packageName" "EXE" "$silentArgs" "$setupPath" -validExitCodes @(0, 3010)

Write-Host "Removing extracted files..."
Remove-Item -Recurse "$extractPath"
