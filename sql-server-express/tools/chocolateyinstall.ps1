$ErrorActionPreference = 'Stop';

$packageName= 'sql-server-express'
$url        = ''
$url64      = 'https://download.microsoft.com/download/7/c/1/7c14e92e-bdcb-4f89-b7cf-93543e7112d1/SQLEXPR_x64_ENU.exe'
$checksum   = 'B85F8A7F810B41AEA93783542E1F05631EAB65ED1E69DB48335CF14D4FE56E736AF99953C1533117E3EFF883FB42FBDCD36EBE99DA6F078FB41DC65FBA0D9128'
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
Install-ChocolateyInstallPackage "$packageName" "EXE" "$silentArgs" "$setupPath" -validExitCodes @(0, 3010, 1116)

Write-Host "Removing extracted files..."
Remove-Item -Recurse "$extractPath"
