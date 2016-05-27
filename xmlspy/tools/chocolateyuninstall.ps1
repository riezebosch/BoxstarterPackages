$ErrorActionPreference = 'Stop';

$packageName= 'xmlspy'
$silentArgs = "{43C550C4-9C42-43DE-ABA7-90AA9220B5E6} /qn"
$fileType   = "msi"

Uninstall-ChocolateyPackage $packageName $fileType $silentArgs -validExitCodes @(0, 3010)
