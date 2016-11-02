# Parse input argument string into a hashtable
# Format: /param1=1234 /param2=1234
function ParseParameters ($s)
{
    $parameters = @{ }

    if (!$s)
    {
        return $parameters
    }

    $kvps = $s.Split(@(" "), [System.StringSplitOptions]::RemoveEmptyEntries)
    foreach ($kvp in $kvps)
    {
        $delimiterIndex = $kvp.IndexOf('=')
        if (($delimiterIndex -le 0) -or ($delimiterIndex -ge ($kvp.Length - 1))) { continue }

        $key = $kvp.Substring(1, $delimiterIndex - 1).Trim().ToLower()
        if ($key -eq '') { continue }
        $value = $kvp.Substring($delimiterIndex + 1).Trim()

        $parameters.Add($key, $value)
    }

    return $parameters
}

# Gets configuraiton file. Returns its path
function GetConfigurationFile($parameters, $defaultConfigurationFile)
{
    $configurationFile = $parameters['ConfigurationFile']

    if (!$configurationFile)
    {
        return $defaultConfigurationFile
    }

    if (($configurationFile.Replace("""", "") -as [System.URI]).AbsoluteURI -ne $null)
    {
        $localConfigurationFile = (Join-Path $env:temp 'Configuration.ini')

        if (Test-Path $localConfigurationFile)
        {
            Remove-Item $localConfigurationFile
        }

        Get-ChocolateyWebFile 'ConfigurationFile' $localConfigurationFile $configurationFile.Replace("""", "") | Out-Null
    }
    elseif (Test-Path $configurationFile)
    {
        $localConfigurationFile = $configurationFile;
    }
    else
    {
        throw 'Invalid Configuration File.'
    }

    return $localConfigurationFile
}

function GenerateInstallArguments($parameters, $configurationFile)
{
    $s = "/IAcceptSQLServerLicenseTerms /ConfigurationFile=""$($configurationFile)"""

    foreach ($key in $parameters.Keys)
    {
        if ($key -eq 'configurationfile') { continue };

        $value = $parameters[$key]

        $s = $s + " /$key=$value"
    }

    return $s
}

function Install {
<#
.SYNOPSIS
Installs SQL Server Express.

.DESCRIPTION
Installs SQL Serve with ability to specify configuraiton file and command line parameters.

.PARAMETER PackageName
The name of the SQLServerExpress package.

.PARAMETER Url
The url of the web installer.

.EXAMPLE
Install '[PackageName]' 'http://download.microsoft.com/download/....'

.OUTPUTS
None

.LINK
Install-ChocolateyPackage
#>
param(
    [string] $packageName,
    [string] $url,
    [string] $url64,
    [string] $checksum,
    [string] $checksum64,
    [string] $exeName
)
    Write-Debug "Running 'Install' for $packageName with url:`'$url`'";

    $installerType = 'exe'
    $validExitCodes = @(
        0, # success
        3010, # success, restart required
        2147781575, # pending restart required
        2147205120  # pending restart required for setup update
    )

    $defaultConfigurationFile = (Join-Path $PSScriptRoot 'Configuration.ini')

    $packageParameters = ParseParameters $env:chocolateyPackageParameters
    $configurationFile = GetConfigurationFile $packageParameters $defaultConfigurationFile
    $silentArgs = GenerateInstallArguments $packageParameters $configurationFile

    Write-Host "Installing with Arguments:
$silentArgs"

    $tempDir = Join-Path $(Get-Item $env:TEMP) $packageName
    $fileFullPath = "$tempDir\SQLEXPR.exe"
    $extractPath = "$tempDir\SQLEXPR"
    $setupPath = "$extractPath\setup.exe"

    # Create the package temporary directory
    New-Item -ItemType Directory -Force -Path $tempDir
    Get-ChocolateyWebFile $packageName $fileFullPath $url $url64 -Checksum $checksum -Checksum64 $checksum64 -ChecksumType "sha1"

    Write-Host "Extracting SQL Server Express Package..."
    Start-Process "$fileFullPath" "/Q /x:`"$extractPath`"" -Wait

    Write-Host "Installing SQL Server Express..."
    Install-ChocolateyInstallPackage "$packageName" "EXE" "$silentArgs" "$setupPath" -validExitCodes @(0, 3010)

    Write-Host "Removing SQL Server Express Extracted Files..."
    rm -r "$extractPath"
}

function Uninstall {
<#
.SYNOPSIS
Uninstalls SQL Server Express.

.DESCRIPTION
Uninstalls SQL Server Express.

.PARAMETER PackageName
The name of the SQLServerExpress package.

.PARAMETER ApplicationName
The VisualStudio app name - i.e. 'Microsoft Visual Studio Community 2015'.

.PARAMETER UninstallerName
This name of the installer executable - i.e. 'vs_community.exe'.

.EXAMPLE
Uninstall 'MSSQLServer2014Express' 'Microsoft Visual Studio Community 2015' 'vs_community.exe'

.OUTPUTS
None

.LINK
Uninstall-ChocolateyPackage
#>
param(
  [string] $packageName,
  [string] $applicationName,
  [string] $uninstallerName
)
    <#
    Write-Debug "Running 'Uninstall-VS' for $packageName with url:`'$url`'";

    $installerType = 'exe'
    $silentArgs = '/Uninstall /force /Passive /NoRestart'

    $app = Get-WmiObject -Class Win32_Product | Where-Object { $_.Name -like "$applicationName*"} | Sort-Object { $_.Name } | Select-Object -First 1
    if ($app -ne $null)
    {
        $uninstaller = Get-Childitem "$env:ProgramData\Package Cache\" -Recurse -Filter $uninstallerName | ? { $_.VersionInfo.ProductVersion.StartsWith($app.Version)}
        if ($uninstaller -ne $null)
        {
            Uninstall-ChocolateyPackage $packageName $installerType $silentArgs $uninstaller.FullName
        }
    }
    #>
}

Export-ModuleMember *