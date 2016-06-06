$ErrorActionPreference = 'Stop';

$packageName= 'xmlspy'
$silentArgs = "{B003B380-0F9C-424D-A965-FDC997092BA6} /qn"
$fileType   = "msi"

Uninstall-ChocolateyPackage $packageName $fileType $silentArgs -validExitCodes @(0, 3010)
