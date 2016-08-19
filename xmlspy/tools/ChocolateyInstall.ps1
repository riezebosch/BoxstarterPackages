
$ErrorActionPreference = 'Stop';


$packageName= 'xmlspy'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://cdn.sw.altova.com/v2016r2sp1a/en/XMLSpyEnt2016rel2sp1.exe'
$url64      = 'http://cdn.sw.altova.com/v2016r2sp1a/en/XMLSpyEnt2016rel2sp1_x64.exe'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'exe'
  url           = $url
  url64bit      = $url64

  silentArgs    = "/qn /l*v `"$env:TEMP\$($packageName).MsiInstall.log`""
  validExitCodes= @(0, 3010, 1641)

  softwareName  = 'xmlspy*'
  checksum      = '23EED3D0F37BDF7F69125A8C32C841C101B6CFBCF8304A8C3DCE26F58E3E90DC'
  checksumType  = 'sha256'
  checksum64    = '137A20EFB709FC5BDCB0FB334F0B414A202AEDE5B22575AB9D0BF44C735672AA'
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













