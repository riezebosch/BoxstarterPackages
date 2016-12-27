$packageName = 'soapui' # arbitrary name for the package, used in messages
$fileType = 'exe'
$url = 'http://cdn01.downloads.smartbear.com/soapui/5.3.0/SoapUI-x32-5.3.0.exe'
$url64 = 'http://cdn01.downloads.smartbear.com/soapui/5.3.0/SoapUI-x64-5.3.0.exe'
$checksum = 'BA44B5EAF05472FF22C42CBED7C02BCF278A5A25B56842117A19ACE8EA69F6EE'
$checksum64 = '73604FBECAD8A6022F084ED808A8D347CAA47E7B04CEC22E6782E91A6EA56634'

Install-ChocolateyPackage $packageName $fileType '-q' $url $url64 -checksum $checksum -checksum64 $checksum64 -checksumType 'sha256'
