########################################################
## Default VM Settings                                ##
########################################################
#Set Timezone
#& $env:windir\System32\tzutil.exe /s "W. Europe Standard Time"
#Write-Host "Timezone set to W. Europe Standard Time"


$TZ = Get-TimeZone -ListAvailable | Select-Object -ExpandProperty Id | Where-Object { $_ -like '*W. Europe*' }
Set-TimeZone -Id $TZ

#Set Firewall
Set-NetFirewallProfile -Profile Domain -Enabled false

