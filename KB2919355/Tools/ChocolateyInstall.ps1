$kb = "KB2919355"
$packageName = "KB2919355"
$installerType = "msu"
$silentArgs = "/quiet /norestart /log:`"$env:TEMP\$kb.Install.log`""
$windowsVersion = [Version](Get-CimInstance Win32_OperatingSystem).Version
$windowsProductType = (Get-CimInstance Win32_OperatingSystem).ProductType

if (!(($windowsVersion -ge [Version]'6.3') -and ($windowsVersion -lt [Version]'6.4')))
{
	throw "Only Windows 8.1 and Windows Server 2012 R2 are supported"
}

# Windows 8.1 x86
$url = "http://download.microsoft.com/download/4/E/C/4EC66C83-1E15-43FD-B591-63FB7A1A5C04/Windows8.1-KB2919355-x86.msu"

if ($windowsProductType -eq '1')
{
	# Windows 8.1 x64
	$url64 = "http://download.microsoft.com/download/D/B/1/DB1F29FC-316D-481E-B435-1654BA185DCF/Windows8.1-KB2919355-x64.msu"
}
else
{
	# Windows Server 2012 R2
	$url64 = "http://download.microsoft.com/download/2/5/6/256CCCFB-5341-4A8D-A277-8A81B21A1E35/Windows8.1-KB2919355-x64.msu"
}

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" "$url64" -validExitCodes @(0, 3010)

if (Get-HotFix -id $kb -ea SilentlyContinue)
{
	Write-Host("Install success.")
}
else
{
	throw "Hotfix still not applied after install."
}
