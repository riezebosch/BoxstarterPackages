Import-Module au

function global:au_SearchReplace {
    @{
        "tools\chocolateyInstall.ps1" = @{
            "(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL)'"           #1
            "(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"      #2
        }
    }
}

function global:EntryToData($channel) {
    $releases = "https://download.docker.com/win/$channel/appcast.xml"
    [xml]$download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

    # Strip of build number from version
    if (-Not($download_page.rss.channel.item.title -match '\d+\.\d+\.\d+\.\d+')){
        throw 'invalid version spec'
    }
    $version = $Matches[0]

    if ($channel -ne 'stable') {
        $version += "-$channel"
    }

    # AU uses [Uri]::IsWellFormedUriString whereby spaces are not allowed in the Uri.
    $url = ($download_page | Select-Xml -XPath "//@d4w:url" -Namespace @{ d4w = "http://www.docker.com/docker-for-windows"  }).Node.Value -replace ' ', '%20'

    @{ Version = $version; URL = $url }
}

function global:au_GetLatest {
      @{
         Streams = [ordered] @{
            'edge' = EntryToData('edge')
            'stable' = EntryToData('stable')
         }
      }
}

update