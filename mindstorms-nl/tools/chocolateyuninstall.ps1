$ErrorActionPreference = 'Stop';

$packageName = 'mindstorms-nl'
$softwareName = 'LEGO MINDSTORMS EV3'
$installerType = 'EXE' 

$silentArgs = '/qb /x all'
$validExitCodes = @(0, 3010, 1605, 1614, 1641)
if ($installerType -ne 'MSI') {
  $validExitCodes = @(0)
}

$uninstalled = $false
[array]$key = Get-UninstallRegistryKey -SoftwareName $softwareName 
	| Select-Object -First 1 # for some reason there are multiple keys with the software name

if ($key.Count -eq 1) {
  $key | % {
	# slight modification to strip out the quotes and command line arguments
	"$($_.UninstallString)" -match '"(.*)" (.*)'  
    $file = $Matches[1]
	$silentArgs = "$($Matches[2]) $silentArgs"

    if ($installerType -eq 'MSI') {
      $silentArgs = "$($_.PSChildName) $silentArgs"

      $file = ''
    }

    Uninstall-ChocolateyPackage -PackageName $packageName `
                                -FileType $installerType `
                                -SilentArgs "$silentArgs" `
                                -ValidExitCodes $validExitCodes `
                                -File "$file"
  }
} elseif ($key.Count -eq 0) {
  Write-Warning "$packageName has already been uninstalled by other means."
} elseif ($key.Count -gt 1) {
  Write-Warning "$key.Count matches found!"
  Write-Warning "To prevent accidental data loss, no programs will be uninstalled."
  Write-Warning "Please alert package maintainer the following keys were matched:"
  $key | % {Write-Warning "- $_.DisplayName"}
}