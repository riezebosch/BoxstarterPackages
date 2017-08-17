
$ErrorActionPreference = 'Stop';


$packageName= 'xmlspy'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://www.altova.com/download/2017r3sp1/default.asp?product=x&amp;edition=e&amp;server=us'
$checksum   = '220b5e81d29294fb854cbf70d5ac1d875c06a296f5272496c9055b880e52e19d'
$url64      = 'https://www.altova.com/download/2017r3sp1/default.asp?product=x&amp;edition=e&amp;server=us&bit=64'
$checksum64 = '374a3942d7158f3428c07279cbaf542f4254e620aa43de92e1dfa6d471e6b0ba'

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













