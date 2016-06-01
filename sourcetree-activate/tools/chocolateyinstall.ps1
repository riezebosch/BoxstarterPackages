$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
Start-Process -Wait -FilePath $toolsDir\AutoHotkey.exe -ArgumentList $toolsDir\sourcetree-welcome.ahk

