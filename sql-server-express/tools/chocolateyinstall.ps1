#These are the default UI settings
$options = @{
  instanceId = 'MSSQLSERVER'
  instanceName = 'SQLExpress'
  features = '"SQLEngine, Replication"'
  updateEnabled = 'FALSE'
}

$packageParameters = @{
  packageName = 'sql-server-express';
  url = '';
  url64bit = 'https://download.microsoft.com/download/E/1/2/E12B3655-D817-49BA-B934-CEB9DAC0BAF3/SQLEXPR_x64_ENU.exe';
  checksum = '';
  checksumType = '';
  checksum64 = '7D71A44096650E2916B921BE4EC3114EF95A8775';
  checksumType64 = 'Sha1';
  fileFullPath = '';
}

if(!$PSScriptRoot){ $PSScriptRoot = Split-Path $MyInvocation.MyCommand.Path -Parent }
. "$PSScriptRoot\ChocolateyHelpers.ps1"

$tempFolder = Get-ChocolateyPackageTempFolder $packageParameters['packageName']
$packageParameters['fileFullPath'] = "$tempFolder\SQLEXPR.exe"
$extractPath = "$tempFolder\SQLEXPR"

Get-ChocolateyWebFile @packageParameters

Start-Process $packageParameters['fileFullPath'] "/Q /x:`"$extractPath`"" -Wait | Out-Null

$args = New-Object System.Collections.ArrayList
$args.Add('/IACCEPTSQLSERVERLICENSETERMS') | Out-Null
$args.Add('/Q') | Out-Null
$args.Add('/ACTION=Install') | Out-Null

foreach($option in $options.GetEnumerator()) {
  $key = $option.Key.ToUpper()
  $value = $option.Value
  if (!$value) { continue }
  $args.Add("/$key=$value") | Out-Null
}

$joined = $args -join ' '
Write-Host $joined
Install-ChocolateyInstallPackage $packageParameters['packageName'] 'EXE' $joined "$extractPath\setup.exe" -validExitCodes @(0, 3010, 1116)

Export-CliXml -Path (Join-Path $PSScriptRoot 'options.xml') -InputObject $options

#Dont cleanup the media. Add or removing features and instances requires it.
