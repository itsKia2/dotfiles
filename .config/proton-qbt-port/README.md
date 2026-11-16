# proton-qbt-port

Keeps qBittorrent's listening port in sync with the port ProtonVPN forwards.
Runs 2 min after login, then hourly (systemd user timer).

## Files
- `~/.config/proton-qbt-port/proton-qbt-port.sh`
- `~/.config/systemd/user/proton-qbt-port.service`
- `~/.config/systemd/user/proton-qbt-port.timer`

## Setup on a new machine
    sudo pacman -S libnatpmp jq
    sudo ufw allow in on proton0 comment 'ProtonVPN tunnel'
    chmod +x ~/.config/proton-qbt-port/proton-qbt-port.sh
    systemctl --user daemon-reload
    systemctl --user enable --now proton-qbt-port.timer

qBittorrent → Options:
- Web UI: enable, IP 127.0.0.1, port 8080, check "Bypass authentication for clients on localhost"
- Connection: uncheck "Use UPnP / NAT-PMP port forwarding from my router"
- Advanced → Network interface: proton0

Proton app: WireGuard, port forwarding on.

## Use
    systemctl --user start proton-qbt-port.service   # sync now
    journalctl --user -u proton-qbt-port             # logs
