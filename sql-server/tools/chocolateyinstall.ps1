
$ErrorActionPreference = 'Stop'; 

$packageName = 'sql-server'
$url         = 'http://care.dlservice.microsoft.com/dl/download/F/E/9/FE9397FA-BFAB-4ADD-8B97-91234BC774B2/SQLServer2016-x64-ENU.iso' # download url

$user = whoami
$silentArgs  = "/q /ACTION=Install /FEATURES=SQL /INSTANCENAME=MSSQLSERVER /SQLSVCACCOUNT=`"NT AUTHORITY\Network Service`" /SQLSYSADMINACCOUNTS=`"$user`" /AGTSVCACCOUNT=`"NT AUTHORITY\Network Service`" /SQLSVCINSTANTFILEINIT=`"True`" /IACCEPTSQLSERVERLICENSETERMS"

$isolocation = $env:sqlserver:isolocation
if ($isolocation -eq $null) {
    $isolocation = Join-Path $env:userprofile "Downloads"
}

if (![System.IO.Directory]::Exists($isolocation)) { [System.IO.Directory]::CreateDirectory($isolocation) | Out-Null }
$fileFullPath = Join-Path $isolocation "SQLServer2016-x64-ENU.iso"

Get-ChocolateyWebFile $packageName $fileFullPath $url -Checksum "CE21BF1C08EC1AC48EBB4988A8602C7813034EA3" -ChecksumType "sha1"

Mount-DiskImage -ImagePath $fileFullPath
$driveLetter = (Get-DiskImage $fileFullPath | Get-Volume).DriveLetter

Install-ChocolateyInstallPackage $packageName "EXE" $silentArgs "${driveLetter}:\setup.exe" -validExitCodes 0, 3010
