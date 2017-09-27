$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageName= 'sharepoint'
$url        = 'https://download.microsoft.com/download/6/E/3/6E3A0B03-F782-4493-950B-B106A1854DE1/sharepoint.exe'
$checksum   = '5DCA0F664F1C397455288DA76AEFB5B98A3874CB4FB71AD1BA8AE59790249085'

$tempDir = Join-Path (Get-Item $env:TEMP).FullName "$packageName"
if ($env:packageVersion -ne $null) {$tempDir = Join-Path $tempDir "$env:packageVersion"; }

if (![System.IO.Directory]::Exists($tempDir)) { [System.IO.Directory]::CreateDirectory($tempDir) | Out-Null }
$fileFullPath = "$tempDir\sharepoint.exe"

Get-ChocolateyWebFile -PackageName $packageName -FileFullPath $fileFullPath -Url $url -Checksum $checksum -ChecksumType 'sha256'

Write-Host "Extracting..."
$extractPath = "$tempDir\sharepoint"
Start-Process "$fileFullPath" "/extract:`"$extractPath`" /quiet" -Wait

# https://support.microsoft.com/en-us/help/3087184/sharepoint-2013-or-project-server-2013-setup-error-if-the--net-framewo
Write-Host "Installer patch..."
$patchPath = "$tempDir\wsssetup_15-0-4709-1000_x64.zip"
Invoke-WebRequest -Uri "https://download.microsoft.com/download/3/6/2/362c4a9c-4afe-425e-825f-369d34d64f4e/wsssetup_15-0-4709-1000_x64.zip" -OutFile $patchPath
& "$toolsDir\7z.exe" x -aoa $patchPath -o"$extractPath\updates" | Out-Null

Write-Host "Prereq..."
$exit = Start-Process "$extractPath\prerequisiteinstaller.exe" "/unattended" -PassThru -Wait
if ($exit.ExitCode -ne 0) {
    if ($exit.ExitCode -eq 1001 -or $exit.ExitCode -eq 3010) {
        throw "Prereq installed but reboot required."
    } else {
        throw "Prereq failed with exit code $($exit.ExitCode)."
    }
}

Write-Host "Installing..."
$setupPath = "$extractPath\setup.exe"
Install-ChocolateyInstallPackage $packageName "EXE" "/config $toolsDir\config.xml" $setupPath -validExitCodes @(0, 3010, 1116)
