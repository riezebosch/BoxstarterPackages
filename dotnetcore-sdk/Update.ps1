Import-Module au

$releases = "https://www.microsoft.com/net/download/core#/sdk"

function global:au_SearchReplace {
    @{
        "tools\chocolateyInstall.ps1" = @{
            "(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"           #1
            "(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"      #2
            "(^[$]url64\s*=\s*)('.*')"      = "`$1'$($Latest.URL64)'"           #1
            "(^[$]checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"      #2

        }
    }
}

function global:au_GetLatest {
     $download_page = Invoke-WebRequest -Uri $releases

     # select <TH> containing SDK and extract version from it
     ($download_page.AllElements | ? tagName -eq TH | ? innerHtml -match 'SDK').innerText -match '\d\.\d(\.d){0,2}'
     $version = $Matches[0]

     # Add trailing .0 when version is only x.x
     if ($Matches.Count -eq 1) {
         $version = "$version.0"
     }

     $url32 = ($download_page.links | ? href -match 'dotnet-sdk.*-win-x86\.exe$').href
     $url64 = ($download_page.links | ? href -match 'dotnet-sdk.*-win-x64\.exe$').href

     return @{ Version = $version; URL32 = $url32; URL64 = $url64 }
}

update