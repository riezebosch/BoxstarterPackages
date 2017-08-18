Import-Module au

$releases = "https://www.microsoft.com/net/download/core"

$versionpattern = '(?<=<th>.*)\d\.\d(\.\d){0,2}(?=\s+SDK</th>)';        # <TH> with SDK in it
$url32pattern = '(?<=href=[''"]).*dotnet-sdk.*-win-x86\.exe(?=[''"])'   # href with dotnet-sdk x86.exe
$url64pattern = '(?<=href=[''"]).*dotnet-sdk.*-win-x64\.exe(?=[''"])'   # href with dotnet-sdk x64.exe

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
    # use basic parsing because of IE security issues: 
    #   https://github.com/chocolatey/chocolatey-coreteampackages/issues/382
     $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

     $version = ($download_page.RawContent | select-string -AllMatches $versionpattern).Matches.Value
     $url32   = ($download_page.RawContent | select-string -AllMatches $url32pattern).Matches.Value     
     $url64   = ($download_page.RawContent | select-string -AllMatches $url64pattern).Matches.Value     

     return @{ Version = $version; URL32 = $url32; URL64 = $url64 }
}

update