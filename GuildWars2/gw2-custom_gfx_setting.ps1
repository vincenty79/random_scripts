#powershell -ExecutionPolicy Bypass -file .\gw2-custom_gfx_setting.ps1
#https://devblogs.microsoft.com/scripting/use-powershell-to-compare-two-files/
# Paths
$gw2 = "E:\Games\Guild Wars\Guild Wars 2\Gw2-64.exe"
$argue = "-autologin -dx11"
$settingpath = "C:\Users\Vincent\AppData\Roaming\Guild Wars 2"
$myfile = "GFXSettings.Gw2-64.good.xml"
$target = "GFXSettings.Gw2-64.exe.xml"

if	(Compare-Object -ReferenceObject $(Get-Content "$settingpath\$myfile") -DifferenceObject $(Get-Content "$settingpath\$target"))
	{
	#write-output "Files are different"
	copy-item -path "$settingpath\$myfile" -destination "$settingpath\$target"  -force
	& $gw2 $argue
	}

Else
	{
	#write-output "Files are the same"
	& $gw2 $argue
	}