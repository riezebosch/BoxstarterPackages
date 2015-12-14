$packageName = "vs2015.enterprise-iso"
$chocolateyTempDir = Join-Path $env:TEMP "chocolatey"
$tempDir = Join-Path $chocolateyTempDir $packageName
$fileFullPath = "$tempDir\vs2015.1.ent_enu.iso"

if (![System.IO.Directory]::Exists($tempDir)) { [System.IO.Directory]::CreateDirectory($tempDir) | Out-Null }
Get-ChocolateyWebFile $packageName $fileFullPath http://download.microsoft.com/download/6/C/9/6C95B548-64A9-4637-A7F2-EB2A750C7504/vs2015.1.ent_enu.iso -Checksum "EB8DFC731EA4822E57483516BC059BC990260549" -ChecksumType "sha1"

Mount-DiskImage -ImagePath $fileFullPath
$driveLetter = (Get-DiskImage $fileFullPath | Get-Volume).DriveLetter
Install-ChocolateyInstallPackage $packageName "EXE" "/Passive /NoRestart /NoRefresh /NoWeb /Log $env:temp\vs.log" "${driveLetter}:\vs_enterprise.exe" -validExitCodes 0, 3010
