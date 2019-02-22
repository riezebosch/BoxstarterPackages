$packageName = 'soapui' # arbitrary name for the package, used in messages
$fileType = 'exe'
$url = 'https://s3.amazonaws.com/downloads.eviware/soapuios/5.5.0/SoapUI-x32-5.5.0.exe'
$url64 = 'https://s3.amazonaws.com/downloads.eviware/soapuios/5.5.0/SoapUI-x64-5.5.0.exe'
$checksum = '6f32e0f5415e759afcd88bbd19786d16263a36584d38373a54650298e53f84a0'
$checksum64 = 'd88ef3a3cd312105ea7039e8e0ade21d31fe448f23872be69c29ffdbc912ae12'

Install-ChocolateyPackage $packageName $fileType '-q' $url $url64 -checksum $checksum -checksum64 $checksum64 -checksumType 'sha256'
