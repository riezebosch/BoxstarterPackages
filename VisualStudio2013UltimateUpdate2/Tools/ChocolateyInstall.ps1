. (Join-Path $(Split-Path -parent $MyInvocation.MyCommand.Definition) 'common.ps1')

$adminFile = (Join-Path $(Split-Path -parent $MyInvocation.MyCommand.Definition) 'AdminDeployment.xml')
$customArgs = $env:chocolateyInstallArguments
$env:chocolateyInstallArguments=""

$settings = Initialize-VS-Settings $customArgs $adminFile
$installerArgs = Get-VS-Installer-Args $settings.ProductKey

if($customArgs -match "(?:\/iso:(['`"]?)(?<iso>(?:.+?)+)(?:\1))"){
    $iso = Get-Item (-split $matches['iso'])
    Mount-DiskImage -ImagePath $iso
    $driveLetter = (Get-DiskImage $iso | Get-Volume).DriveLetter
    Install-ChocolateyInstallPackage "VisualStudio2013Ultimate" "EXE" $installerArgs "${driveLetter}:\vs_ultimate.exe" -validExitCodes 0, 3010
    Dismount-DiskImage -ImagePath $iso
}
else  {
    Install-ChocolateyPackage 'VisualStudio2013Ultimate' 'exe' $installerArgs 'http://download.microsoft.com/download/5/F/D/5FD90EF6-BED8-4665-9C72-16865B32F159/vs_ultimate.exe'
}
