import-module chocolatey-au

$base      = 'https://www.microsoft.com/en-us/download/'
$productId = '104502'

$detail       = "${base}details.aspx?id=${productId}"
$download     = "${base}confirmation.aspx?id=${productId}"

$reversion    = '(?<Version>([\d]+\.[\d]+\.[\d]+\.[\d]+))'
$reexecutable = '.*>(?<Executable>(.*?\.exe))<'

function global:au_BeforeUpdate {
  $ErrorActionPreference = 'Stop'
  $checksum = Get-RemoteChecksum $Latest.URL64Bit -Algorithm $Latest.ChecksumType64
  if ($checksum -notmatch '^[a-fA-F0-9]{64}$') {
    throw "Failed to calculate a SHA-256 checksum for $($Latest.URL64Bit)"
  }
  $Latest.Checksum64 = $checksum
}

function global:au_SearchReplace {
  @{
    'tools\chocolateyInstall.ps1' = @{
      "(\s*url64bit\s*=\s*)('.*')"       = "`$1'$($Latest.URL64Bit)'"
      "(\s*checksum64\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum64)'"
      "(\s*checksumType64\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType64)'"
    }
  }
}

function global:au_GetLatest {
  $detail_page   = Invoke-WebRequest -UseBasicParsing -Uri $detail

  $detail_page.Content -match $reversion
  $version = $Matches.Version
  Write-Host "Matches: $($Matches.Version)"
  
  $detail_page.Content -match $reexecutable
  $filename = $Matches.Executable
  Write-Host "filename: $filename"
  
  $url = $detail_page.Links | where-object { $_ -Match $filename } | Select-Object -ExpandProperty href | Select-Object -First 1
  Write-Host "url: $url"
  
  @{
    Version        = $version
    URL64Bit       = $url
    Filename64     = $filename
    ChecksumType64 = 'sha256'
  }
}

update -ChecksumFor none -NoReadme
