Import-Module Chocolatey-AU


function global:au_SearchReplace {
    @{
        "tools\chocolateyInstall.ps1" = @{
            "(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"           #1
            "(^[$]url64\s*=\s*)('.*')"    = "`$1'$($Latest.URL64)'"           #1
            "(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"      #2
            "(^[$]checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"    #2
        }
    }
}

function global:au_GetLatest {
    $x86 = Invoke-WebRequest -Uri "https://www.altova.com/ThankYou?productcode=XS&editioncode=E&lang=en&installertype=Product&operatingsystem=win32&FromArchive=true" -UseBasicParsing
    $x86.Content -match '<iframe .* src="(.*)"'

    $url32 = $matches[1]
    $url32 -match '/v(?<v>\d+)(?:r(?<r>\d+))?(?:sp(?<sp>\d+))?'

    $version = "$($matches['v']).$($matches['r'] ?? 0).$($matches['sp'] ?? 0)"

    $x64 = Invoke-WebRequest -Uri "https://www.altova.com/ThankYou?productcode=XS&editioncode=E&lang=en&installertype=Product&operatingsystem=win64&FromArchive=true" -UseBasicParsing
    $x64.Content -match '<iframe .* src="(.*)"'
    $url64 = $matches[1]

    @{ Version = $version; URL32 = $url32; URL64 = $url64 }
}

update
