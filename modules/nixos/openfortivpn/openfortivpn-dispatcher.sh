#!/bin/sh
flag=/run/openfortivpn-was-active
if [ "$2" = "connectivity-change" ]; then
  case "$CONNECTIVITY_STATE" in
  none)
    if systemctl is-active --quiet openfortivpn; then
      touch "$flag"
    fi
    systemctl --no-block stop openfortivpn
    ;;
  full)
    if [ -f "$flag" ]; then
      rm "$flag"
      systemctl --no-block start openfortivpn
    fi
    ;;
  esac
fi
