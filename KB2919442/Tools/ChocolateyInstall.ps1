$kb = "KB2919442"
$packageName = "KB2919442"
$installerType = "msu"
$silentArgs = "/quiet /norestart /log:`"$env:TEMP\$kb.Install.log`""

# Get-CimInstance only available on Powershell v3+ which is shipped since Windows 8 & Windows Server 2012
$os = Get-CimInstance Win32_OperatingSystem -ea SilentlyContinue 
$version = [Version]$os.Version

if ($version -eq $null -or $version -lt [Version]'6.3' -or $version -ge [Version]'6.4') {
	Write-Host "Skipping installation because this hotfix only applies to Windows 8.1 and Windows Server 2012 R2."
	return
}

if (Get-HotFix -id $kb -ea SilentlyContinue)
{
	Write-Host "Skipping installation because hotfix $kb is already installed."
	return
}

if ($os.ProductType -eq '1') {
	# Windows 8.1
	$url = "http://download.microsoft.com/download/9/D/A/9DA6C939-9E65-4681-BBBE-A8F73A5C116F/Windows8.1-KB2919442-x86.msu"
	$url64 = "http://download.microsoft.com/download/C/F/8/CF821C31-38C7-4C5C-89BB-B283059269AF/Windows8.1-KB2919442-x64.msu"
} else {
	# Windows Server 2012 R2
	$url64 = "http://download.microsoft.com/download/D/6/0/D60ED3E0-93A5-4505-8F6A-8D0A5DA16C8A/Windows8.1-KB2919442-x64.msu"
}

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" "$url64" -validExitCodes @(0, 3010)

if (!(Get-HotFix -id $kb -ea SilentlyContinue)) {
	throw "Hotfix still not found after installation was completed!"
}