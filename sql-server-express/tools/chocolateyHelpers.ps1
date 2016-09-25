function Get-ChocolateyPackageTempFolder {
    param(
      [string] $packageName
    )
    $tempDir = Join-Path $Env:Temp $packageName
    if (![System.IO.Directory]::Exists($tempDir)) {[System.IO.Directory]::CreateDirectory($tempDir) | Out-Null}
   
    return $tempDir
}

function Set-ChocolateyPackageOptions {
    param(
        [Parameter(Mandatory=$True,Position=1)]
        [hashtable] $options
    )
    $packageParameters = $env:chocolateyPackageParameters;

    if ($packageParameters) {
        $parameters = ConvertFrom-StringData -StringData $env:chocolateyPackageParameters.Replace(" ", "`n")
        $parameters.GetEnumerator() | ForEach-Object {
           $options[($_.Key)] = ($_.Value)
        }
    }
}