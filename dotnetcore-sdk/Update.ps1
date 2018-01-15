Import-Module au

$releases = "https://raw.githubusercontent.com/dotnet/core/master/release-notes/releases.json"

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
     $info = (Invoke-WebRequest -Uri $releases -UseBasicParsing | ConvertFrom-Json)[0]
    
     $exe32 = [System.IO.Path]::ChangeExtension($info.'sdk-win-x86', 'exe')
     $exe64 = [System.IO.Path]::ChangeExtension($info.'sdk-win-x64', 'exe')
     $version = $info.'version-sdk'
     $url32   = $info.'dlc-sdk' + $exe32
     $url64   = $info.'dlc-sdk' + $exe64

     return @{ Version = $version; URL32 = $url32; URL64 = $url64 }
}

update