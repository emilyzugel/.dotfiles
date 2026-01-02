#!/bin/bash

# Check if ProtonVPN CLI returns info
info=$(protonvpn info 2>/dev/null)

if [[ -z "$info" ]]; then
  status="Disconnected"

else
  status="Connected"

fi

# Get public IP
ip=$(curl -s https://ifconfig.me)

# Get country from IP (optional, uses freegeoip)
country=$(curl -s https://ipapi.co/$ip/country_name/)

echo ""
echo "=== 📌 ProtonVPN Quick Commands: ==="
echo "help      : protonvpn --help"
echo "signin    : protonvpn signin"
echo "signout   : protonvpn signout"
echo "connect   : protonvpn connect (optional: --country XX, --protocol wireguard)"
echo "disconnect: protonvpn disconnect"
echo "info      : protonvpn info"
echo ""

# Print dashboard
echo "=== 🔹 ProtonVPN Status ==="
echo "Status   : $status"
echo "Country  : $country"
echo "IP       : $ip"
