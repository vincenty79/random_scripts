Write-Host "use arguement (arc | taco | all)"

if ( $args -eq "arc" ) { 
Write-Host "Updating arcdps"
Invoke-WebRequest https://www.deltaconnected.com/arcdps/x64/d3d9.dll `
-OutFile "G:\Guild Wars\Guild Wars 2\bin64\d3d9.dll"
}

elseif ( $args -eq "taco" ) {
Write-Host "Updating taco marker"
Invoke-WebRequest http://www.tekkitsworkshop.net/index.php/gw2-taco/download/send/2-taco-marker-packs/32-all-in-one `
-outfile "G:\Guild Wars\TacO\POIs\tw_ALL_IN_ONE.zip"
}

elseif ( $args -eq "all" ) {
Write-Host "Updating arcdps"
Invoke-WebRequest https://www.deltaconnected.com/arcdps/x64/d3d9.dll `
-OutFile "G:\Guild Wars\Guild Wars 2\bin64\d3d9.dll"

Write-Host "Updating taco marker"
Invoke-WebRequest http://www.tekkitsworkshop.net/index.php/gw2-taco/download/send/2-taco-marker-packs/32-all-in-one `
-outfile "G:\Guild Wars\TacO\POIs\tw_ALL_IN_ONE.zip"
}

else {
Write-Host "Please enter an arguement. Example: arcdps_update.ps1 taco"
}