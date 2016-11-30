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
param(
    [string] $packageName,
    [string] $url,
    [string] $url64,
    [string] $checksum,
    [string] $checksum64,
    [string] $exeName,
    [string] $defaultConfigurationFile
)
    Write-Debug "Running 'Install' for $packageName with url:`'$url`'";

    $installerType = 'exe'
    $validExitCodes = @(
        0, # success
        3010, # success, restart required
        2147781575, # pending restart required
        2147205120  # pending restart required for setup update
    )

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

Export-ModuleMember *