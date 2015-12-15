$packageName = "AspNet5.ENU.RC1_Update1"
$params = "/install /passive /norestart /log $env:temp\aspnet.log"
$url = "https://download.microsoft.com/download/B/0/A/B0AEBD7D-6979-4265-B1AC-A0B73618FB22/AspNet5.ENU.RC1_Update1.exe"
Install-ChocolateyPackage $packageName "exe" $params $url