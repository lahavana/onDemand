########################################################
## Default VM Settings                                ##
########################################################
#Set Timezone
& tzutil /s "W. Europe Standard Time"
Write-Host "Timezone set to W. Europe Standard Time"

#Set Firewall
Set-NetFirewallProfile -Profile Domain -Enabled false

