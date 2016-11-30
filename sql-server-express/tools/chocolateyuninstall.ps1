$packageName = 'sql-server-express'

if(!$PSScriptRoot){ $PSScriptRoot = Split-Path $MyInvocation.MyCommand.Path -Parent }
. "$PSScriptRoot\ChocolateyHelpers.ps1"

$tempFolder = Get-ChocolateyPackageTempFolder $packageName
$setupPath = "$tempFolder\SQLEXPR\setup.exe"

$optionsFile = (Join-Path $PSScriptRoot 'options.xml')
if (!(Test-Path $optionsFile)) {
  throw "Install options file missing. Could not uninstall."
}

$options = Import-CliXml -Path $optionsFile

$args = New-Object System.Collections.ArrayList
$args.Add('/Q') | Out-Null
$args.Add('/ACTION=Uninstall') | Out-Null
$args.Add("/INSTANCENAME=$($options['instanceName'])") | Out-Null
$args.Add("/FEATURES=$($options['features'])") | Out-Null

$joined = $args -join ' '

Uninstall-ChocolateyPackage $packageName 'EXE' $joined "$setupPath" -validExitCodes @(0, 3010)