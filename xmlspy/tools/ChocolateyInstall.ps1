
$ErrorActionPreference = 'Stop';

$packageName= 'xmlspy'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://cdn.sw.altova.com/v2020r2hf2/en/XMLSpyEnt2020rel2.exe'
$checksum   = '49277f982d997c50c8c6e298d6d4a2edc15ef372c496740fcc5f65cbeff8469a'
$url64      = 'https://cdn.sw.altova.com/v2020r2hf2/en/XMLSpyEnt2020rel2_x64.exe'
$checksum64 = '158cc01edd881fce74acc2ff41fa25b26d95d71fa6e557fd4b2e4bc32def4636'

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
