. (Join-Path $(Split-Path -parent $MyInvocation.MyCommand.Definition) 'Install-WindowsUpdate.ps1')

Install-WindowsUpdate "KB2919355" 'http://download.microsoft.com/download/D/B/1/DB1F29FC-316D-481E-B435-1654BA185DCF/Windows8.1-KB2919355-x64.msu' "Windows8.1-KB2919355-x64.msu" "Windows8.1-KB2919355-x64.cab"