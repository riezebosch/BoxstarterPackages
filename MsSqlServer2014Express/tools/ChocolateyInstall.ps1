Import-Module (Join-Path $(Split-Path -parent $MyInvocation.MyCommand.Definition) 'Helpers.psm1')

Install 'MSSQLServer2014Express' `
        'https://download.microsoft.com/download/1/5/6/156992E6-F7C7-4E55-833D-249BD2348138/ENU/x86/SQLEXPR_x86_ENU.exe' `
        'https://download.microsoft.com/download/1/5/6/156992E6-F7C7-4E55-833D-249BD2348138/ENU/x64/SQLEXPR_x64_ENU.exe' `
        '33C0112905B62B6BAD883112C2F49B50AA12C679' `
        '0C90C147A1C2A550165C9301AE7A6C604E318E51' `
        'SQLEXPR.exe'