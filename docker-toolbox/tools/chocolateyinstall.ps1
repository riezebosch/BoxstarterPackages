
$ErrorActionPreference = 'Stop';


$packageName= 'docker-toolbox'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://github.com/docker/toolbox/releases/download/v18.09.0/DockerToolbox-18.09.0.exe'
$checksum  =  '5971379f1c2a1a7d200330a2042097d5c0820097dfdaeacc031c1475f8dfd683'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url

  softwareName  = 'docker-toolbox*'

  checksum      = $checksum
  checksumType  = 'sha256'

  silentArgs    = "/COMPONENTS=`"docker,dockermachine,dockercompose`" /TASKS=`"modifypath,upgradevm`" /silent /norestart /log=`"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).log`""
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs


















