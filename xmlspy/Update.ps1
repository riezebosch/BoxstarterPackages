Import-Module au

$releases = "https://www.altova.com/download/2017r3sp1/default.asp?product=x&edition=e&server=us"

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
     $current = iwr 'https://www.altova.com/download_current.html'
     $tag = ($current.AllElements | ? tagName -eq 'strong').innerText;
     $version = ($tag | Select-String -AllMatches '\d+').Matches -join '.'

     $download = iwr 'https://www.altova.com/download-trial.html'
     $url32 = 'https://www.altova.com' + ($download.links | ? href -match 'product=x').href
     $url64 = "$url32&bit=64"

     return @{ Version = $version; URL32 = $url32; URL64 = $url64 }
}

update