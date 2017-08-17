Import-Module au

$releases = "https://github.com/docker/toolbox/releases/latest"

function global:au_SearchReplace {
    @{
        "tools\chocolateyInstall.ps1" = @{
            "(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"           #1
            "(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"      #2
        }
    }
}

function global:au_GetLatest {
     $latest = iwr -Uri $releases

     ($latest.AllElements | ? class -Match release-title).InnerText -match '(?<=v)\d+\.\d+\.\d+'
     $version = $Matches[0]

     $url32 = "https://github.com$(($latest.Links | ? href -match \.exe$).href)"

     return @{ Version = $version; URL32 = $url32; }
}

update