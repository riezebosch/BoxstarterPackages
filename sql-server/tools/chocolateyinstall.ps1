
$ErrorActionPreference = 'Stop'; 

$packageName = 'sql-server'
$url         = 'http://care.dlservice.microsoft.com/dl/download/F/E/9/FE9397FA-BFAB-4ADD-8B97-91234BC774B2/SQLServer2016-x64-ENU.iso' # download url

$user = whoami
$silentArgs  = "/q /ACTION=Install /FEATURES=SQL /INSTANCENAME=MSSQLSERVER /SQLSVCACCOUNT=`"NT AUTHORITY\Network Service`" /SQLSYSADMINACCOUNTS=`"$user`" /AGTSVCACCOUNT=`"NT AUTHORITY\Network Service`" /SQLSVCINSTANTFILEINIT=`"True`" /IACCEPTSQLSERVERLICENSETERMS"

#$chocTempDir =Join-Path (Get-Item $env:TEMP).FullName "chocolatey"
#$tempDir = Join-Path $chocTempDir "$packageName"
#if ($env:packageVersion -ne $null) {$tempDir = Join-Path $tempDir "$env:packageVersion"; }
$tempDir = "C:\SQL2016"

if (![System.IO.Directory]::Exists($tempDir)) { [System.IO.Directory]::CreateDirectory($tempDir) | Out-Null }
$fileFullPath = Join-Path $tempDir "SQLServer2016-x64-ENU.iso"

Get-ChocolateyWebFile $packageName $fileFullPath $url -Checksum "CE21BF1C08EC1AC48EBB4988A8602C7813034EA3" -ChecksumType "sha1"
WRite-Host $fileFullPath
Mount-DiskImage -ImagePath $fileFullPath
$driveLetter = (Get-DiskImage $fileFullPath | Get-Volume).DriveLetter
Install-ChocolateyInstallPackage $packageName "EXE" $silentArgs "${driveLetter}:\setup.exe" -validExitCodes 0, 3010
