$installer = "$env:TEMP\Docker for Windows Installer.exe"
Start-BitsTransfer -Source https://download.docker.com/win/edge/Docker%20for%20Windows%20Installer.exe -Destination $installer
$output = & $installer "check-for-update" | Select-String -Pattern "version=(\d+), displayVersion=([0-9.]+)"
$version = "$($output.Matches.Groups[2]).$($output.Matches.Groups[1])"

Write-Output "Version from installer: $version"
$spec = "docker-for-windows.nuspec"
(gc -Path $spec -Encoding UTF8) -replace "<version>.*</version>", "<version>$version-edge</version>" | Out-File $spec -Encoding utf8

$checksum = & checksum -f $installer -t sha256
Write-Host "Checksum: $checksum"
$install = ".\tools\chocolateyinstall.ps1"
(gc -Path $install) -replace "checksum      = '.*'", "checksum      = '$checksum'" | Out-File $install -Encoding utf8