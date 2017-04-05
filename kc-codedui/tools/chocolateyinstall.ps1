Write-Output "Update path"
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User") 

Write-Output "Create docker env"
& docker-machine create --driver hyperv --hyperv-virtual-switch 'External Network' Default

Write-Output "Configure shell for docker-machine"
& "C:\Program Files\Docker Toolbox\docker-machine.exe" env | Invoke-Expression

Write-Output "Run music store image"
& docker run -p 5000:80 -t -d --name musicstore mriezebosch/musicstore:1.1

Write-Output "Grab docker-machine ip"
$ip = & docker-machine ip

Write-Output "Create shortcut"
$shell = New-Object -ComObject WScript.Shell
$shortcut = $shell.CreateShortcut("$Home\Desktop\Music Store.url")
$shortcut.TargetPath = "http://$($ip):5000/"
$shortcut.Save()