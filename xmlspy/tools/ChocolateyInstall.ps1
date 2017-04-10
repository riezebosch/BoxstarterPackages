
$ErrorActionPreference = 'Stop';


$packageName= 'xmlspy'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://cdn.sw.altova.com/v2017r3a/en/XMLSpyEnt2017rel3.exe?file.exe'
$url64      = 'https://cdn.sw.altova.com/v2017r3a/en/XMLSpyEnt2017rel3_x64.exe?file.exe'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'exe'
  url           = $url
  url64bit      = $url64

  silentArgs    = "/qn /l*v `"$env:TEMP\$($packageName).MsiInstall.log`""
  validExitCodes= @(0, 3010, 1641)

  softwareName  = 'xmlspy*'
  checksum      = 'C27828EF87C1DCE7D07D66D52B21C019CE60852C250FBF98DC649A7F2F4D81B5'
  checksumType  = 'sha256'
  checksum64    = '3B1D7C8D9624158D2142109904585851A4798BEDDE67EA28AD97B0BBF6401E39'
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













