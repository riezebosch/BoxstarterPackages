. (Join-Path $(Split-Path -parent $MyInvocation.MyCommand.Definition) 'Install-WindowsUpdate.ps1')

$windowsVersion = (Get-CimInstance Win32_OperatingSystem).version
$windowsProductType = (Get-WmiObject Win32_OperatingSystem).ProductType
$windowsArchitecture = (Get-WmiObject Win32_OperatingSystem).OSArchitecture

if (!(($windowsVersion -ge 6.3) -and ($windowsVersion -lt 6.4)))
{
	throw "Only Windows 8.1 and Winodws Server 2012 R2 are supported"
}

if ($windowsArchitecture -eq '64-bit')
{
	#64-bit
	if ($windowsProductType -eq '1')
	{
		# Windows 8.1 x64
		$url = "http://download.microsoft.com/download/C/F/8/CF821C31-38C7-4C5C-89BB-B283059269AF/"
	}
	else
	{
		# Windows Server 2012 R2
		$url = "http://download.microsoft.com/download/D/6/0/D60ED3E0-93A5-4505-8F6A-8D0A5DA16C8A/"
	}

	$fileName = "Windows8.1-KB2919442-x64"
}
else
{
	# Windows 8.1 x86
	$url = "http://download.microsoft.com/download/9/D/A/9DA6C939-9E65-4681-BBBE-A8F73A5C116F/"
	$fileName = "Windows8.1-KB2919442-x86"
}

Install-WindowsUpdate "KB2919442" "$url$fileName.msu" "$fileName.msu" "$fileName.cab"