########################################################
## Default VM Settings                                ##
########################################################
#Set Timezone
& "$env:windir\System32\tzutil.exe /s "W. Europe Standard Time"
Write-Host "Timezone set to W. Europe Standard Time"

#Set Firewall
Set-NetFirewallProfile -Profile Domain -Enabled false

