#!/usr/bin/env bash
# Sets qBittorrent's listening port to the port ProtonVPN is forwarding
#
# Dependencies:
#   - libnatpmp  (provides natpmpc)   sudo pacman -S libnatpmp
#   - jq                              sudo pacman -S jq
#   - curl, iproute2 (ip)             already installed on Arch
#   - qBittorrent Web UI on 127.0.0.1:8080 with
#     "Bypass authentication for clients on localhost" checked
#   - ProtonVPN app connected over WireGuard with port forwarding on (interface proton0)

IFACE=proton0
GW=10.2.0.1
QBT=http://127.0.0.1:8080

ip link show "$IFACE" &>/dev/null || exit 0   # VPN not connected, nothing to do

port=$(natpmpc -g "$GW" -a 1 0 tcp 60 2>/dev/null | awk '/Mapped public port/ {print $4; exit}')
[[ "$port" =~ ^[0-9]+$ ]] || { echo "Couldn't get forwarded port"; exit 1; }

current=$(curl -s "$QBT/api/v2/app/preferences" | jq -r .listen_port)
if [[ "$current" != "$port" ]]; then
  curl -s --data "json={\"listen_port\":$port}" "$QBT/api/v2/app/setPreferences" \
    && echo "qBittorrent port: $current -> $port"
fi
