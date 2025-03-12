$ErrorActionPreference = 'Stop'

Get-Service SqlServerReportingServices -ErrorAction SilentlyContinue | Stop-Service
