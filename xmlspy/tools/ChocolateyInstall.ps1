
$ErrorActionPreference = 'Stop';


$packageName= 'xmlspy'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://cdn.sw.altova.com/v2017r3sp1a/en/XMLSpyEnt2017rel3sp1.exe'
$url64      = 'https://cdn.sw.altova.com/v2017r3sp1a/en/XMLSpyEnt2017rel3sp1_x64.exe'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'exe'
  url           = $url
  url64bit      = $url64

  silentArgs    = "/qn /l*v `"$env:TEMP\$($packageName).MsiInstall.log`""
  validExitCodes= @(0, 3010, 1641)

  softwareName  = 'xmlspy*'
  checksum      = '220B5E81D29294FB854CBF70D5AC1D875C06A296F5272496C9055B880E52E19D'
  checksumType  = 'sha256'
  checksum64    = '374A3942D7158F3428C07279CBAF542F4254E620AA43DE92E1DFA6D471E6B0BA'
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













