$ErrorActionPreference = 'Stop';

$packageName= 'xmlspy'
$silentArgs = "{4388A388-E22A-4B99-BD13-8B3DC2F84943} /qn"
$fileType   = "msi"

Uninstall-ChocolateyPackage $packageName $fileType $silentArgs -validExitCodes @(0, 3010)
