# OS Optimizations for AVD
 write-host 'AIB Customization: OS Optimizations for AVD'
 $appName = 'install'
 $drive = 'C:'
 New-Item -Path $drive -Name $appName -ItemType Directory -ErrorAction SilentlyContinue
 $LocalPath = $drive + '\' + $appName
 New-Item -Path $LocalPath -Name "optimize" -ItemType Directory -ErrorAction SilentlyContinue
 $LocalPath = "$LocalPath\optimize"
 set-Location "$LocalPath"
 write-host "The current path is $LocalPath"
 
 $osOptURL = 'https://wbgcitrixinfraeawapps.blob.core.windows.net/baseline/CitrixOptimizerTool.zip'
 $osOptURLexe = 'CitrixOptimizer.zip'
 $outputPath = $LocalPath + '\' + $osOptURLexe
 Invoke-WebRequest -Uri $osOptURL -OutFile $outputPath
 write-host 'AIB Customization: Starting OS Optimizations with Citrix Optimizer'
 Expand-Archive -LiteralPath $outputPath -DestinationPath $($Localpath+"\"+$($osOptURLexe.Split('.')[0])) -Force -Verbose
 #Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Force -Verbose
 Set-Location -Path "$LocalPath\\CitrixOptimizer"
 $Template = "$LocalPath\\CitrixOptimizer"


 #Run Citrix Optimize
 .\CtxOptimizerEngine.ps1 "$Template\\Templates\Citrix_Windows_Server_2019_1809.xml" -Mode Execute
 write-host 'AIB Customization: Finished OS Optimizations for WVD with Citrix Optimizer'
