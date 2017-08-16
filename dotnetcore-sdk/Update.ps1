Import-Module au

$releases = "https://www.microsoft.com/net/download/core#/sdk"

function global:au_SearchReplace {
    @{
        "tools\chocolateyInstall.ps1" = @{
            "(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL)'"           #1
            "(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"      #2
        }
    }
}

function global:au_GetLatest {
     $download_page = Invoke-WebRequest -Uri $releases
     $regex32 = 'dotnet-sdk.*-win-x86\.exe$'
     $regex64 = 'dotnet-sdk.*-win-x64\.exe$'

     $download_page.RawContent -match '(?<=<th>.NET Core\s*)\d+\.\d+(.\d){0,2}(?=\s*SDK</th>)'
     $version = $Matches[0]

     if ($Matches.Count -eq 1) {
         $version = "$version.0"
     }

     $url32 = $download_page.links | ? href -match $regex32 | select -First 1 -expand href
     $url64 = $download_page.links | ? href -match $regex64 | select -First 1 -expand href

     return @{ Version = $version; URL32 = $url32; URL64 = $url64 }
}

update