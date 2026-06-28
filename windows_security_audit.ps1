# Windows Security Audit Script
# Beginner cybersecurity portfolio project

$ReportPath = "$env:USERPROFILE\Desktop\Security_Audit_Report.txt"

"Windows Security Audit Report" | Out-File $ReportPath
"Generated: $(Get-Date)" | Out-File $ReportPath -Append
"======================================" | Out-File $ReportPath -Append

"`n[Windows Defender Status]" | Out-File $ReportPath -Append
Get-MpComputerStatus | Select-Object AMServiceEnabled, AntivirusEnabled, RealTimeProtectionEnabled, AntispywareEnabled | Out-File $ReportPath -Append

"`n[Firewall Status]" | Out-File $ReportPath -Append
Get-NetFirewallProfile | Select-Object Name, Enabled | Out-File $ReportPath -Append

"`n[Open Network Connections]" | Out-File $ReportPath -Append
Get-NetTCPConnection | Select-Object LocalAddress, LocalPort, RemoteAddress, RemotePort, State | Out-File $ReportPath -Append

"`n[Local Users]" | Out-File $ReportPath -Append
Get-LocalUser | Select-Object Name, Enabled, LastLogon | Out-File $ReportPath -Append

"`n[Running Processes]" | Out-File $ReportPath -Append
Get-Process | Select-Object ProcessName, Id, CPU | Sort-Object CPU -Descending | Select-Object -First 20 | Out-File $ReportPath -Append

"`n[Recent Failed Login Events]" | Out-File $ReportPath -Append
Get-WinEvent -FilterHashtable @{LogName='Security'; Id=4625} -MaxEvents 10 -ErrorAction SilentlyContinue | 
Select-Object TimeCreated, Id, ProviderName, Message | Out-File $ReportPath -Append

"`nAudit complete. Report saved to: $ReportPath" | Out-File $ReportPath -Append

Write-Host "Security audit complete!"
Write-Host "Report saved to: $ReportPath"