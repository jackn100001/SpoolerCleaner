param (
    [int]$age = 15
    $path = 'C:\Windows\System32\spool\PRINTERS'
)

Write-Output "Stopping print spooler..."
Stop-Service -Name Spooler -Force

$limit = (Get-Date).AddDays($age)

# Delete files older than the $limit.
Write-Output "Deleting spooler files created $($age) or more days ago"
Get-ChildItem -Path $path -Recurse -Force | Where-Object { $_.CreationTime -lt $limit -and !$_.PSIsContainer } | Remove-Item -Force

Write-Output "Starting print spooler..."
Start-Service -Name Spooler
