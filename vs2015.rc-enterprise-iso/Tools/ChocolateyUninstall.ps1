$packageName = "vs2013.4-ultimate-iso"
$app = Get-WmiObject -Class Win32_Product | Where-Object { $_.Name -eq "Microsoft Visual Studio Enterprise 2015 RC" }
if($app -ne $null){
    $version=$app.Version
    $uninstaller=Get-Childitem "$env:ProgramData\Package Cache\" -Recurse -Filter vs_ultimate.exe
    Uninstall-ChocolateyPackage $packageName 'exe' "/Uninstall /force /Passive /NoRestart" $uninstaller.FullName
}