flag=/run/openfortivpn-was-active
if systemctl is-active --quiet openfortivpn; then
  systemctl stop openfortivpn
  rm -f "$flag"
  notify-send "OpenFortiVPN" "Disconnected"
else
  if [ "$(nmcli -t networking connectivity check)" != "full" ]; then
    notify-send "OpenFortiVPN" "Cannot connect: no active internet connection"
    exit 1
  fi
  systemctl start openfortivpn
  notify-send "OpenFortiVPN" "Connected"
fi
