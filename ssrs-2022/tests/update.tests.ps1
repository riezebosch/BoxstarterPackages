$ErrorActionPreference = 'Stop'

$updater = Join-Path (Split-Path $PSScriptRoot -Parent) 'update.ps1'
$installer = Join-Path (Split-Path $PSScriptRoot -Parent) 'tools/chocolateyinstall.ps1'
$url = 'https://example.test/SQLServerReportingServices.exe'
$hash = 'a' * 64

New-Module -Name chocolatey-au -ScriptBlock {
  function Get-RemoteChecksum {
    param([string] $Url, [string] $Algorithm)

    $global:checksumRequest = @{ Url = $Url; Algorithm = $Algorithm }
    if ($global:checksumFailure) { Write-Error 'Download failed' }
    return $global:checksumResult
  }

  function update {
    param([string] $ChecksumFor, [switch] $NoReadme)

    if ($ChecksumFor -ne 'none') { throw 'Expected the custom checksum hook' }
    $global:Latest = @{ URL64Bit = $global:testUrl; ChecksumType64 = 'sha256' }
    if (!(Test-Path Function:\au_BeforeUpdate)) { throw 'AU cannot see au_BeforeUpdate' }
    au_BeforeUpdate
    $replacements = (au_SearchReplace)['tools\chocolateyInstall.ps1']
    $content = Get-Content -Raw $global:testInstaller
    foreach ($pattern in $replacements.Keys) {
      $content = $content -replace $pattern, $replacements[$pattern]
    }
    return $content
  }
  Export-ModuleMember -Function Get-RemoteChecksum, update
} | Import-Module

function global:Import-Module {
  param([string] $Name)
  if ($Name -ne 'chocolatey-au') { throw "Unexpected module: $Name" }
}

try {
  $global:testUrl = $url
  $global:testInstaller = $installer
  $global:checksumResult = $hash
  $global:checksumFailure = $false

  $result = & $updater
  if ($result -notmatch "checksum64\s*=\s*'$hash'") { throw 'Installer checksum was not updated' }
  if ($result -notmatch "url64bit\s*=\s*'$([regex]::Escape($url))'") { throw 'Installer URL was not updated' }
  if ($global:checksumRequest.Url -ne $url -or $global:checksumRequest.Algorithm -ne 'sha256') {
    throw 'Checksum request used the wrong URL or algorithm'
  }

  foreach ($invalid in @('', 'not-a-hash')) {
    $global:checksumResult = $invalid
    try {
      & $updater
      throw 'Expected invalid checksum to fail'
    } catch {
      if ($_ -notmatch 'Failed to calculate a SHA-256 checksum') { throw }
    }
  }

  $global:checksumFailure = $true
  try {
    & $updater
    throw 'Expected checksum download to fail'
  } catch {
    if ($_ -notmatch 'Download failed') { throw }
  }
  Write-Host 'SSRS updater checksum tests passed'
} finally {
  Remove-Module chocolatey-au
  Remove-Item Function:\au_BeforeUpdate, Function:\au_GetLatest, Function:\au_SearchReplace, Function:\Import-Module -ErrorAction SilentlyContinue
  Remove-Variable Latest, testUrl, testInstaller, checksumResult, checksumFailure, checksumRequest -Scope Global -ErrorAction SilentlyContinue
}
