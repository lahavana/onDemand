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

write-host "Start download of language packs from Microsoft"
Start-BitsTransfer -Source "https://software-static.download.prss.microsoft.com/dbazure/888969d5-f34g-4e03-ac9d-1f9786c66749/26100.1.240331-1435.ge_release_amd64fre_CLIENT_LOF_PACKAGES_OEM.iso" -Destination "01_LANGUAGEPACK.iso"
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

