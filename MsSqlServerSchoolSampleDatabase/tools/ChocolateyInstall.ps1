if ($env:chocolateyPackageParameters -Match "instance=([`"'])?([a-zA-Z0-9- _.\\]+)\1") {
   $instance = $match[1]
} else {
    $instances = gi 'HKLM:\Software\Microsoft\Microsoft SQL Server\Instance Names\SQL' | select -ExpandProperty property
    if ($instances -contains "MSSQLSERVER") {
        $instance = "."
    } elseif ($instances -contains "SQLEXPRESS") {
        $instance = ".\SQLEXPRESS"
    } elseif ($instances.Length -ne 0) {
        $instance = $instances | select -first 1
    } else {
        throw "Failed to find a SQL instance!"
    }
}

Write-Host "SQL instance: $instance"

$installPath = (get-itemproperty -Path 'HKLM:\Software\Microsoft\Microsoft SQL Server\*\Tools\ClientSetup' -Name Path -ErrorAction SilentlyContinue).Path
$sqlcmd = $installPath | gci -Filter sqlcmd.exe | select -last 1
if ($sqlcmd -eq $null) {
    throw "SQLCMD not found!"
}

Write-Host "SQLCMD: $($sqlcmd.FullName)"

$url = 'http://msdn.microsoft.com/en-US/library/bb399731(v=vs.100).aspx'
$html = (Invoke-Webrequest $url).ParsedHTML
$sql = ($html.getElementsByTagName("pre") | select -First 1).innerHTML.Replace('&gt;', '>')
& $sqlcmd.FullName -S $instance -Q $sql