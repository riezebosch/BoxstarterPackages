$MSIFile = "$env:TEMP\InstallDocker.msi"
(New-Object System.Net.WebClient).DownloadFile('https://download.docker.com/win/beta/InstallDocker.msi', $MSIFile)

. .\Get-DockerVersion.ps1
$version = Get-DockerForWindowsVersion "$env:TEMP\InstallDocker.msi"

$spec = "docker-for-windows.nuspec"
(gc -Path $spec -Encoding UTF8) -replace "<version>.*</version>", "<version>$version-beta</version>" | Out-File $spec -Encoding utf8

$install = ".\tools\chocolateyinstall.ps1"
(gc -Path $install -Encoding UTF8) -replace "\`$version = `".*`"", "`$version = `"$version`"" | Out-File $install -Encoding utf8

$checksum = Invoke-WebRequest -Uri "https://download.docker.com/win/beta/$version/InstallDocker.msi.sha256sum" -UseBasicParsing
(gc -Path $install -Encoding UTF8) -replace "checksum      = '.*'", "checksum      = '$($checksum.Content.SubString(0, 64))'" | Out-File $install -Encoding utf8