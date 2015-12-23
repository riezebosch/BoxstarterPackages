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
		$url = "http://download.microsoft.com/download/D/B/1/DB1F29FC-316D-481E-B435-1654BA185DCF/"
	}
	else
	{
		# Windows Server 2012 R2
		$url = "http://download.microsoft.com/download/2/5/6/256CCCFB-5341-4A8D-A277-8A81B21A1E35/"
	}

	$fileName = "Windows8.1-KB2919355-x64"
}
else
{
	# Windows 8.1 x86
	$url = "http://download.microsoft.com/download/4/E/C/4EC66C83-1E15-43FD-B591-63FB7A1A5C04/"
	$fileName = "Windows8.1-KB2919355-x86"
}

Install-WindowsUpdate "KB2919355" "$url$fileName.msu" "$fileName.msu" "$fileName.cab"