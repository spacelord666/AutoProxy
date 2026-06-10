# --- CONFIGURATION ---
$TargetSSID   = "SSID_NAME"
$ProxyAddress = "IP_ADDRESS:PORT_NUMBER"
# ---------------------

# PAUSE FOR TIMING: Wait 5 seconds for Windows to finish negotiating the connection
# and fully populate the Network Profile Name.
Start-Sleep -Seconds 5

# 1. Get the current Wi-Fi SSID/Profile Name
$CurrentSSID = (Get-NetConnectionProfile -InterfaceAlias "Wi-Fi" -ErrorAction SilentlyContinue).Name

# Fallback method if Get-NetConnectionProfile returns blank
if (-not $CurrentSSID) {
    $CurrentSSID = (netsh wlan show interfaces | Select-String "\bSSID\s*:\s*(.*)") | ForEach-Object { $_.Matches.Groups[1].Value.Trim() }
}

# Registry path for Internet Settings
$RegPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings"

# 2. Evaluate using a wildcard match to handle Windows profile numbering
if ($CurrentSSID -like "*$TargetSSID*") {
    Set-ItemProperty -Path $RegPath -Name ProxyEnable -Value 1
    Set-ItemProperty -Path $RegPath -Name ProxyServer -Value $ProxyAddress
    # Optional: Log to a file to verify it worked while running hidden
    "$(Get-Date): Connected to $CurrentSSID. Proxy ENABLED." | Out-File -FilePath "C:\AutoProxy\proxy_log.txt" -Append
} else {
    Set-ItemProperty -Path $RegPath -Name ProxyEnable -Value 0
    "$(Get-Date): Connected to $CurrentSSID. Proxy DISABLED." | Out-File -FilePath "C:\AutoProxy\proxy_log.txt" -Append
}

# 3. Force Windows to refresh internet settings immediately so the toggle flips
$signature = '[DllImport("wininet.dll")] public static extern bool InternetSetOption(IntPtr hInternet, int dwOption, IntPtr lpBuffer, int dwBufferLength);'
$type = Add-Type -MemberDefinition $signature -Name WinInetUtils -Namespace WinInet -PassThru
[void]$type::InternetSetOption([IntPtr]::Zero, 39, [IntPtr]::Zero, 0) # INTERNET_OPTION_SETTINGS_CHANGED
[void]$type::InternetSetOption([IntPtr]::Zero, 37, [IntPtr]::Zero, 0) # INTERNET_OPTION_REFRESH