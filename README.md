AutoProxy will automatically enable your Windows proxy (turn ON) and disable (turn OFF) when connected to your normal connection.

How to use: <b><br>
This is a POWER SHELL script.
1. Open Powershell
2. Run the script ./AutoProxy.ps1
<br>
NOTE: <br>
Some systems have executing scripts turned off, you will need to either:<br>
1. Override the security setting to run (this script, this time only)<br>
powershell.exe -ExecutionPolicy Bypass -File "C:\path\to\AutoProxy.ps1"<br>
<br>
In scheduler: <br>
WindowStyle Hidden -ExecutionPolicy Bypass -File "C:\Scripts\AutoProxy.ps1"<br>
<br>
2. Allow Powershell script execution<br>
Open Powershell as Administrator<br>
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force<br>
<br>
User editable changes:<br>
$TargetSSID   = "SSID_NAME"
Change SSID_NAME to the name of your hotspot SSID (the name that shows up in Wireless Connections)<br>
example:<br>
$TargetSSID   = "Tmobile_Hotspot"
etc...
<br><br>
$ProxyAddress = "IP_ADDRESS:PORT_NUMBER"<br>
Change IPP_ADDRESS:PORT_NUMBER to match your hotspot/proxy<br>
example:
$ProxyAddress = "192.168.1.77:8080"
<br><br>
Common ports are: 8080, 8100, 8101, 8282 etc...<br>
<br>
Startup SLEEP timer allows the connection to be established before making the change. This allows Windows enough time to make a connection before
the script gets passed to the ELSE statement.<br>
<br>
Change: Start-Sleep -Seconds 5 to the number of seconds you require. If your system takes 45 seconds to connect change it to:
Start-Sleep -Seconds 45


