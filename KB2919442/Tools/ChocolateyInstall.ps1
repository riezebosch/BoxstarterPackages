$kb = "KB2919442"
$packageName = "KB2919442"
$installerType = "msu"
$silentArgs = "/quiet /norestart /log:`"$env:TEMP\KB2919442.Install.log`""
$windowsVersion = [Version](Get-CimInstance Win32_OperatingSystem).Version
$windowsProductType = (Get-CimInstance Win32_OperatingSystem).ProductType

if (!(($windowsVersion -ge [Version]'6.3') -and ($windowsVersion -lt [Version]'6.4')))
{
	throw "Only Windows 8.1 and Winodws Server 2012 R2 are supported"
}

# Windows 8.1 x86
$url = "http://download.microsoft.com/download/9/D/A/9DA6C939-9E65-4681-BBBE-A8F73A5C116F/Windows8.1-KB2919442-x86.msu"

if ($windowsProductType -eq '1')
{
	# Windows 8.1 x64
	$url64 = "http://download.microsoft.com/download/C/F/8/CF821C31-38C7-4C5C-89BB-B283059269AF/Windows8.1-KB2919442-x64.msu"
}
else
{
	# Windows Server 2012 R2
	$url64 = "http://download.microsoft.com/download/D/6/0/D60ED3E0-93A5-4505-8F6A-8D0A5DA16C8A/Windows8.1-KB2919442-x64.msu"
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