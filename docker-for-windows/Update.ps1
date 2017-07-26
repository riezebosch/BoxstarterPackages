Import-Module au

$releases = "https://download.docker.com/win/stable/appcast.xml"

function global:au_SearchReplace {
    @{
        "tools\chocolateyInstall.ps1" = @{
            "(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL)'"           #1
            "(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"      #2
        }
    }
}

function global:au_GetLatest {
     [xml]$download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
     $regex = $download_page.rss.channel.item.title | Select-String -Pattern "([0-9.]+).*\((\d+)\)"
     $version = "$($regex.Matches.Groups[1]).$($regex.Matches.Groups[2])"

     # AU uses [Uri]::IsWellFormedUriString whereby spaces are not allowed in the Uri.
     $url = ($download_page | Select-Xml -XPath "//@url").Node.Value -replace ' ', '%20'
    
     return @{ Version = $version; URL = $url }
}

update