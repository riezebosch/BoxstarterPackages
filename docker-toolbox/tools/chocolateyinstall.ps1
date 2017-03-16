
$ErrorActionPreference = 'Stop';


$packageName= 'docker-toolbox'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://download.docker.com/win/stable/DockerToolbox.exe'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  url64bit      = $url64

  softwareName  = 'docker-toolbox*'

  checksum      = 'DDE1714D951FC6FD7DFF7B63412A64083E1702F1B0707C3CD5F8BAEB797D7EA6'
  checksumType  = 'sha256'

  silentArgs    = "/COMPONENTS=`"docker,dockermachine,dockercompose`" /TASKS=`"modifypath,upgradevm`" /silent /norestart /log=`"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).log`""
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs


















