$MSIFile = "$env:TEMP\InstallDocker.msi"
if (!(Test-Path $MSIFile)) {
    (New-Object System.Net.WebClient).DownloadFile('https://download.docker.com/win/beta/InstallDocker.msi', $MSIFile)
}

. .\Get-DockerVersion.ps1
$version = Get-DockerForWindowsVersion "$env:TEMP\InstallDocker.msi"

$spec = "docker-for-windows.nuspec"
(gc -Path $spec) -replace "<version>.+</version>", "<version>$version-beta</version>" | Out-File $spec

$install = ".\tools\chocolateyinstall.ps1"
(gc -Path $install) -replace "\`$version = `".+`"", "`$version = `"$version`"" | Out-File $install

$checksum = Invoke-WebRequest -Uri "https://download.docker.com/win/beta/$version/InstallDocker.msi.sha256sum" -UseBasicParsing
(gc -Path $install) -replace "checksum      = '.+'", "checksum      = '$($checksum.Content.SubString(0, 64))'" | Out-File $install