function Install-WindowsUpdate([string]$kb, [Uri]$url, [string]$file, [string]$cab)
{
	if (!(Get-HotFix -id $kb))
	{
		$temp = (Get-Item -LiteralPath $env:TEMP).FullName
		$out = Join-Path $temp $file
		$extractPath = Join-Path $temp $kb
		$packagePath = Join-Path $extractPath $cab
		$logPath = Join-Path $extractPath "dism.log"

		Write-Host("Downloading package...")
		Invoke-WebRequest -Uri $url -OutFile $out

		Write-Host("Installing update $kb...")
		&wusa $out /extract:$extractPath
		&dism.exe /Online /Add-Package /PackagePath:$packagePath /NoRestart /Quiet /LogPath:$logPath

		if (Get-HotFix -id $kb)
		{
			Write-Host("Install success.")
			rm -r "$extractPath"
		}
		else
		{
			Write-Error("Hotfix still not applied after install.")
		}
	}
}