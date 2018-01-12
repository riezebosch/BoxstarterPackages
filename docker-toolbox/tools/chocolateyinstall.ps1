
$ErrorActionPreference = 'Stop';


$packageName= 'docker-toolbox'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://github.com/docker/toolbox/releases/download/v18.01.0-ce/DockerToolbox-18.01.0-ce.exe'
$checksum  =  '77749ec090246e27dccdc3a8fb2a237b5a2960edb1a5f5aacc831fbfe206b529'

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


















