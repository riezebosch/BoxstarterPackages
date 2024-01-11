$ErrorActionPreference = 'Stop'
$Version = "5.7.2"
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64      = "https://dl.eviware.com/soapuios/$Version/SoapUI-x64-$Version.exe"



$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url64bit      = $url64
  softwareName  = 'soapui*'
  checksum64    = '3e270e539f6a0f44a3619f2d91ef4d0daa56bfa2230813893295fb7c1da67c49'
  checksumType64= 'sha256'
  silentArgs    = "-q"
  validExitCodes= @(0, 3010, 1641)
}

$regKey = Get-UninstallRegistryKey  -SoftwareName $packageArgs['softwareName'] 

if ($regKey)
{
  $regPath = $regKey | 
                 Select-Object -ExpandProperty PSParentPath | 
                 Convert-Path

  # Throw terminating error if 32bit version of app is installed
  if ($regPath -eq 'HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall')
  {
    Write-Warning ( '"{0}" is installed, the final 32 bit version available is 5.5.0' -f $regKey.DisplayName  ) 
  }
}

Install-ChocolateyPackage @packageArgs
