$packageName = 'soapui' # arbitrary name for the package, used in messages
$fileType = 'exe'
$url = 'https://s3.amazonaws.com/downloads.eviware/soapuios/5.4.0/SoapUI-x32-5.4.0.exe'
$url64 = 'https://s3.amazonaws.com/downloads.eviware/soapuios/5.4.0/SoapUI-x64-5.4.0.exe'
$checksum = 'c249fa1260e10d97192635aa4c671c125ea3dc003750db8173abdbfc38516767'
$checksum64 = '3be4ba27bad4dcb22ffb96df4d09eaf97408c4bd69cca62732b1dbaa19e25784'

Install-ChocolateyPackage $packageName $fileType '-q' $url $url64 -checksum $checksum -checksum64 $checksum64 -checksumType 'sha256'
