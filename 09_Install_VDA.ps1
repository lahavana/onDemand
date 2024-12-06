#VDA Installation
write-host 'AIB Customization: Install Citrix VDA without WorkspaceApp'
 $appName = 'VDA'
 $drive = 'C:\install'
 New-Item -Path $drive -Name $appName -ItemType Directory -ErrorAction SilentlyContinue
 $LocalPath = $drive + '\' + $appName
 set-Location "$LocalPath"
 write-host "AIB Customization: The current path is $LocalPath"

$osOptURL = 'https://wbgcitrixinfraeawapps.blob.core.windows.net/baseline/VDAServerSetup_2203_CU3.exe'
 $osOptURLexe = 'VDAServerSetup.exe'
 $outputPath = $LocalPath + '\' + $osOptURLexe

write-host 'AIB Customization: Starting Download of Citrix VDA '
Start-BitsTransfer -Source $osOptURL -Destination $outputPath
Get-BitsTransfer

write-host ""Test-File ".\$osOptURLexe"""
Test-Path ".\$osOptURLexe"

#Invoke-WebRequest -Uri $osOptURL -OutFile $outputPath

write-host  "AIB Customization: Citrix VDA Installation"
& .\VDAServerSetup.exe /extract $LocalPath
#start-process ".\VDAServerSetup.exe" -ArgumentList "/extract $LocalPath"
#start-process ".\Extract\Image-Full\Support\DotNet48\ndp48-x86-x64-allos-enu.exe" -ArgumentList '/q'
start-sleep 5
#write-host ""Test-File ".\Extract\Image-Full\Support\DotNet48\ndp48-x86-x64-allos-enu.exe"""
#Test-Path ".\Extract\Image-Full\Support\DotNet48\ndp48-x86-x64-allos-enu.exe"
#& .\VDAServerSetup.exe /components vda /disableexperiencemetrics /enable_hdx_ports /enable_hdx_udp_ports /enable_real_time_transport /enable_remote_assistance /enable_ss_ports /includeadditional "Citrix Profile Management","Citrix Profile Management WMI Plug-in" /exclude "Citrix Personalization for App-V - VDA","Citrix Supportability Tools","Citrix WEM Agent","Citrix MCS IODriver","Citrix VDA Upgrade Agent" /mastermcsimage /noreboot /virtualmachine
& .\VDAServerSetup.exe /components vda /enable_hdx_ports /enable_hdx_udp_ports /enable_real_time_transport /enable_remote_assistance /enable_ss_ports /includeadditional "Citrix Profile Management","Citrix Profile Management WMI Plug-in","Citrix Rendezvous V2" /exclude "Citrix Personalization for App-V - VDA","Citrix Supportability Tools","Citrix MCS IODriver","Citrix VDA Upgrade Agent" /mastermcsimage /noreboot /quiet /virtualmachine /xendesktopcloud

write-host 'AIB Customization: Finished Install of Citrix VDA'
