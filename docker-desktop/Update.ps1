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
    "$releases"

    [xml]$download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

    # Strip of build number from version
    $download_page.rss.channel.item.title -match '\d+\.\d+\.\d+\.\d+'
    $version = $Matches[0]

    if ($channel -ne 'stable') {
        $version += "-$channel"
    }

    return @{ Version = $version; URL = $download_page.rss.channel.link }
}

function global:au_GetLatest {
      @{
         Streams = [ordered] @{
            'stable' = EntryToData('stable')
            'edge' = EntryToData('edge')
         }
      }
}

update