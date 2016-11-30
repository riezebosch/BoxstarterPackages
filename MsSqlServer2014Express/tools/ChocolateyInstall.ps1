Import-Module (Join-Path $PSScriptRoot 'Helpers.psm1')

$package = 'MSSQLServer2014Express' 
$url = "https://download.microsoft.com/download/2/A/5/2A5260C3-4143-47D8-9823-E91BB0121F94/SQLEXPR_x86_ENU.exe"
$url64 = "https://download.microsoft.com/download/2/A/5/2A5260C3-4143-47D8-9823-E91BB0121F94/SQLEXPR_x64_ENU.exe"
$checksum = '0eff1354916410437c829e98989e5910d9605b2df31977bc33ca492405a0a9ab'
$checksum64 = 'cc35e94030a24093a62e333e900c2e3c8f1eb253a5d73230a9f5527f1046825b'
$configurationFile = Join-Path -Resolve $PSScriptRoot '..\Configuration.ini' 

Install $package $url $url64 $checksum $checksum64 'SQLEXPR.exe' $configurationFile