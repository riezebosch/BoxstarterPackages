$packageName = 'soapui' # arbitrary name for the package, used in messages
$fileType = 'exe'
$url = 'http://cdn01.downloads.smartbear.com/soapui/5.2.1/SoapUI-x32-5.2.1.exe'
$url64 = 'http://cdn01.downloads.smartbear.com/soapui/5.2.1/SoapUI-x64-5.2.1.exe'
$checksum = '267D8120AF8B0A04FC195131C0B6A14775FF3850DC1C551F13B931C900F02773'
$checksum64 = 'FCF8306D91B126CCB2A0DA82729F7481A74E71EF0045B6C5136D724F0D9C5ECA'

Install-ChocolateyPackage $packageName $fileType '-q' $url $url64 -checksum $checksum -checksum64 $checksum64 -checksumType 'sha256'
