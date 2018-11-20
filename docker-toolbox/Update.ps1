Import-Module au

$releases = "https://api.github.com/repos/docker/toolbox/releases"

function global:au_SearchReplace {
    @{
        "tools\chocolateyInstall.ps1" = @{
            "(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"           #1
            "(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"      #2
        }
    }
}

function global:au_GetLatest {
    $latest = (Invoke-RestMethod -Uri $releases) | ?{ $_.prerelease -eq $false } | select -First 1
    $version = $latest.tag_name -replace 'v(\d+.\d+.\d+)', '$1'
    $asset = $latest.assets | ?{ $_.name -match '\.exe$' }
     
     return @{ Version = $version; URL32 = $asset.browser_download_url; }
}

update