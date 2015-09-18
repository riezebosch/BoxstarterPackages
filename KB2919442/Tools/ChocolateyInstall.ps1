. (Join-Path $(Split-Path -parent $MyInvocation.MyCommand.Definition) 'Install-WindowsUpdate.ps1')

Install-WindowsUpdate "KB2919442" 'http://download.microsoft.com/download/C/F/8/CF821C31-38C7-4C5C-89BB-B283059269AF/Windows8.1-KB2919442-x64.msu' "Windows8.1-KB2919442-x64.msu" "Windows8.1-KB2919442-x64.cab"