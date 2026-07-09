Import-Module Chocolatey-AU

# disable the url check since docker is returning 403's for no apparent reasons
# au is using oldskool WebRequests: https://github.com/chocolatey-community/chocolatey-au/blob/master/src/Private/request.ps1
function global:check_url() {
}

function global:au_SearchReplace {
    @{
        "tools\chocolateyInstall.ps1" = @{
            "(^[$]url64\s*=\s*)('.*')"      = "`$1'$($Latest.url64bit)'"           #1
            "(^[$]checksum64\s*=\s*)('.*')" = "`$1'$($Latest.checksum64)'"      #2
        }
    }
}

function global:au_GetLatest {
    $releases = "https://desktop.docker.com/win/main/amd64/appcast.json"
    $appcast = Invoke-RestMethod -Uri $releases

    $item = $appcast.Items | Select-Object -First 1
    $version = $item.AppVersion
    $artifact = $item.Artifacts | Where-Object { $_.Type -eq "msi" } | Select-Object -First 1
    $url = $artifact.URL
    $checksum = $artifact.Checksum

    @{ Version = $version; url64bit = $url; checksum64 = $checksum }
}

Update-Package -ChecksumFor none
