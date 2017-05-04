$channel = "stable"
$installer = "$env:TEMP\DockerToolbox.$channel.exe"
(New-Object System.Net.WebClient).DownloadFile("https://download.docker.com/win/$channel/DockerToolbox.exe", $installer)

if (!([System.Diagnostics.FileVersionInfo]::GetVersionInfo($installer).ProductVersion.ToString() -match '\d+\.\d+\.\d+')) {
    Write-Error 'failed to extract version from installer'
    return;
}
$version = $Matches[0]

Write-Output "Version from installer: $version"
$spec = "docker-toolbox.nuspec"
(gc -Path $spec -Encoding UTF8) -replace "<version>.*</version>", "<version>$version</version>" | Out-File $spec -Encoding utf8

$checksum = & checksum -f $installer -t sha256
Write-Host "Checksum: $checksum"
$install = ".\tools\chocolateyinstall.ps1"
(gc -Path $install) -replace "checksum      = '.*'", "checksum      = '$checksum'" | Out-File $install -Encoding utf8