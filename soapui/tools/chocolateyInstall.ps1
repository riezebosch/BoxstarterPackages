$ErrorActionPreference = 'Stop'
$Version = "5.9.1"
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64      = "https://dl.eviware.com/soapuios/$Version/SoapUI-x64-$Version.exe"



$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url64bit      = $url64
  softwareName  = 'soapui*'
  checksum64    = '677FC0FB7E4DA870DE9F4ECEC99445DDF7DAC346D8E6655CA5762B0377B18748'
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
