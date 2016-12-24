$MSIFile = "$env:TEMP\InstallDocker.msi"
(New-Object System.Net.WebClient).DownloadFile('https://download.docker.com/win/stable/InstallDocker.msi', $MSIFile)

. .\Get-DockerVersion.ps1
$version = Get-DockerForWindowsVersion "$env:TEMP\InstallDocker.msi"
Write-Output "Version from msi: $version"

$spec = "docker-for-windows.nuspec"
(gc -Path $spec -Encoding UTF8) -replace "<version>.*</version>", "<version>$version</version>" | Out-File $spec -Encoding utf8

$install = ".\tools\chocolateyinstall.ps1"
(gc -Path $install) -replace "\`$version = `".*`"", "`$version = `"$version`"" | Out-File $install -Encoding utf8

$checksum = Invoke-WebRequest -Uri "https://download.docker.com/win/stable/$version/InstallDocker.msi.sha256sum" -UseBasicParsing
(gc -Path $install) -replace "checksum      = '.*'", "checksum      = '$($checksum.Content.SubString(0, 64))'" | Out-File $install -Encoding utf8