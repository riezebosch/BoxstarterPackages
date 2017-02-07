$channel = "stable"
$MSIFile = "$env:TEMP\InstallDocker.$channel.msi"
(New-Object System.Net.WebClient).DownloadFile("https://download.docker.com/win/$channel/InstallDocker.msi", $MSIFile)

. .\Get-DockerVersion.ps1
$version = Get-DockerForWindowsVersion $MSIFile
Write-Output "Version from msi: $version"

$spec = "docker-for-windows.nuspec"
(gc -Path $spec -Encoding UTF8) -replace "<version>.*</version>", "<version>$version</version>" | Out-File $spec -Encoding utf8

$install = ".\tools\chocolateyinstall.ps1"
(gc -Path $install) -replace "\`$version = `".*`"", "`$version = `"$version`"" | Out-File $install -Encoding utf8

$checksumUrl = "https://download.docker.com/win/$channel/$version/InstallDocker.msi.sha256sum"
$checksum = Invoke-WebRequest -Uri $checksumUrl -UseBasicParsing -ea SilentlyContinue
if ($checksum -ne $null) {
    $checksum = $checksum.Content.SubString(0, 64)
}
else {
    Write-Warning "Checksum download failed from url $checksumUrl. Calculating locally."
    $checksum = . checksum -f $MSIFile -t sha256
}

Write-Host "Checksum: $checksum"
(gc -Path $install) -replace "checksum      = '.*'", "checksum      = '$checksum'" | Out-File $install -Encoding utf8