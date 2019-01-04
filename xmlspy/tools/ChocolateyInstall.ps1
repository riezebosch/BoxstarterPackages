
$ErrorActionPreference = 'Stop';

$packageName= 'xmlspy'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://cdn.sw.altova.com/v2019sp1/en/XMLSpyEnt2019sp1.exe'
$checksum   = '16b3d25ce7c2cd092314bd2e1a597794629348743062d96810936aa9ddb66b67'
$url64      = 'https://cdn.sw.altova.com/v2019sp1/en/XMLSpyEnt2019sp1_x64.exe'
$checksum64 = 'aaa9f5cf756d2e63c94796ca485dc6e6eece88e2f0f40c2afbcc19707a899283'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'exe'
  url           = $url
  url64bit      = $url64

  silentArgs    = "/qn /l*v `"$env:TEMP\$($packageName).MsiInstall.log`""
  validExitCodes= @(0, 3010, 1641)

  softwareName  = 'xmlspy*'
  checksum      = $checksum
  checksumType  = 'sha256'
  checksum64    = $checksum64
  checksumType64= 'sha256'
}


# HACK: The XMLSpy installer fails when this key is already present.
$key = "MenuExt"
$path = "HKCU:\SOFTWARE\Microsoft\Internet Explorer\$key"
Rename-Item -Path $path  -NewName "$key BAK" -ea SilentlyContinue

Try {
	Install-ChocolateyPackage @packageArgs
}
Finally {
	# Restore the hack.
	Remove-Item -Path $path -Recurse -ea SilentlyContinue
	Rename-Item -Path "$path BAK"  -NewName $key -ea SilentlyContinue
}
