[xml]$data = iwr "https://download.docker.com/win/edge/appcast.xml"
$match = $data.rss.channel.item.title | Select-String -Pattern "([0-9.]+).*\((\d+)\)"
$version = "$($match.Matches.Groups[1]).$($match.Matches.Groups[2])"
Write-Output "Version from installer: $version"

$spec = "docker-for-windows.nuspec"
(gc -Path $spec -Encoding UTF8) -replace "<version>.*</version>", "<version>$version-edge</version>" | Out-File $spec -Encoding utf8

$url = $data.rss.channel.link
$checksum = (iwr "$($url).sha256sum" -UseBasicParsing).Content.Split(' ')[0]

Write-Host "Checksum: $checksum"
$install = ".\tools\chocolateyinstall.ps1"
(gc -Path $install) -replace "checksum      = '.*'", "checksum      = '$checksum'" | Out-File $install -Encoding utf8
(gc -Path $install) -replace '\$url        = ''.*''', "`$url        = '$url'" | Out-File $install -Encoding utf8
