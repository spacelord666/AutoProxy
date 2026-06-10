AutoProxy will automatically enable your Windows proxy (turn ON) and disable (turn OFF) when connected to your normal connection.

User editable changes:
$TargetSSID   = "SSID_NAME"
Change SSID_NAME to the name of your hotspot SSID (the name that shows up in Wireless Connections)
example:
$TargetSSID   = "Tmobile_Hotspot"
etc...

$ProxyAddress = "IP_ADDRESS:PORT_NUMBER"
Change IPP_ADDRESS:PORT_NUMBER to match your hotspot/proxy
example:
$ProxyAddress = "192.168.1.77:8080"

Common ports are: 8080, 8100, 8101, 8282 etc...

Startup SLEEP timer allows the connection to be established before making the change. This allows Windows enough time to make a connection before
the script gets passed to the ELSE statement.

Change: Start-Sleep -Seconds 5 to the number of seconds you require. If your system takes 45 seconds to connect change it to:
Start-Sleep -Seconds 45


