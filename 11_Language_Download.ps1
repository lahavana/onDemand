#https://docs.microsoft.com/en-us/azure/virtual-desktop/windows-11-language-packs#requirements


 # OS Optimizations for WVD
 write-host 'AIB Customization: Download additional languages'
 $appName = 'install'
 $drive = 'C:'
 New-Item -Path $drive -Name $appName -ItemType Directory -ErrorAction SilentlyContinue
 $LocalPath = $drive + '\' + $appName
 New-Item -Path $LocalPath -Name "language" -ItemType Directory -ErrorAction SilentlyContinue
 $LocalPath = "$LocalPath\language"
 set-Location "$LocalPath"
 write-host "The current path is $LocalPath"
 $LanguageShare = New-Item -Path $LocalPath -Name "LanguagesAndOptionalFeatures" -ItemType Directory -ErrorAction SilentlyContinue

<#
write-host "Start 1st download Azure"
get-date
Invoke-WebRequest -Uri "https://sawvdautimation.blob.core.windows.net/wvdoptimization/01_LANGUAGEPACK.iso" -OutFile "01_LANGUAGEPACK.iso"
write-host "Finished 1st download Azure"
write-host "Start 2nd download Azure"
get-date
Invoke-WebRequest -Uri "https://sawvdautimation.blob.core.windows.net/wvdoptimization/02_FODPACK.iso" -OutFile "02_FODPACK.iso"
write-host "Finished 2nd download Azure"
write-host "Start 3rd download Azure"
get-date
Invoke-WebRequest -Uri "https://sawvdautimation.blob.core.windows.net/wvdoptimization/03_InboxApps.iso" -OutFile "03_InboxApps.iso"
write-host "Finished 3rd download Azure"
#>

write-host "Start download of language packs from Microsoft"
Start-BitsTransfer -Source "https://software-download.microsoft.com/download/sg/22000.1.210604-1628.co_release_amd64fre_CLIENT_LOF_PACKAGES_OEM.iso" -Destination "01_LANGUAGEPACK.iso"
Get-BitsTransfer

write-host "Available Windows 10 1809 Languages and Features on Demand table."
Start-BitsTransfer -Source "https://download.microsoft.com/download/7/6/0/7600F9DC-C296-4CF8-B92A-2D85BAFBD5D2/Windows-10-1809-FOD-to-LP-Mapping-Table.xlsx"
Get-BitsTransfer

$isos = Get-Childitem -Path $LocalPath -Include *.iso -Recurse


foreach ($iso in $isos.name)
    {
    $Mount = Mount-DiskImage -ImagePath $($LocalPath+"\"+$iso)
    write-host $($LocalPath+"\"+$iso)
    $driveLetter = ($mount | Get-Volume).DriveLetter
        
        if (Test-Path $($driveLetter+":\LanguagesAndOptionalFeatures"))
            {
            write-host "$($driveLetter+":\LanguagesAndOptionalFeatures") exists"
            Copy-Item $($driveLetter+":\LanguagesAndOptionalFeatures\*") -Destination $LanguageShare -Recurse
            Copy-Item $($LocalPath+"\*.xlsx") -Destination $LanguageShare -Recurse
            }
    }



write-host 'AIB Customization: Finished download languages script'


<#
#write-host "Start 1st download"
#Invoke-WebRequest -Uri "https://software-download.microsoft.com/download/pr/19041.1.191206-1406.vb_release_CLIENTLANGPACKDVD_OEM_MULTI.iso" -OutFile "01_LANGUAGEPACK.iso"
#write-host "Finished 1st download"
#write-host "Start 2nd download"
#Invoke-WebRequest -Uri "https://software-download.microsoft.com/download/pr/19041.1.191206-1406.vb_release_amd64fre_FOD-PACKAGES_OEM_PT1_amd64fre_MULTI.iso" -OutFile "02_FODPACK.iso"
#write-host "Finished 2nd download"
#write-host "Start 3rd download"
#Invoke-WebRequest -Uri "https://software-download.microsoft.com/download/pr/19041.508.200905-1327.vb_release_svc_prod1_amd64fre_InboxApps.iso" -OutFile "03_InboxApps.iso"
#write-host "Finished 3rd download"
#>
