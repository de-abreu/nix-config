{ cfg }:
# bash
''
  STATE_FILE="''${XDG_RUNTIME_DIR:-/run/user/$UID}/monitor-toggle/state"
  mkdir -p "$(dirname "$STATE_FILE")"

  if [ ! -f "$STATE_FILE" ] || [ "$(cat "$STATE_FILE")" = "extended" ]; then
    # Switch to Mirror Mode
    hyprctl keyword monitor "${cfg.secondary},preferred,auto,1,mirror,${cfg.primary}"
    echo "mirrored" > "$STATE_FILE"
    notify-send "Display Mode" "Screen Mirrored"
  else
    # Switch back to Extended Mode — disable secondary, then re-enable without mirror
    # to let Hyprland re-apply the default monitor config
    hyprctl keyword monitor "${cfg.secondary},disable"
    hyprctl keyword monitor "${cfg.secondary},preferred,auto,1"
    echo "extended" > "$STATE_FILE"
    notify-send "Display Mode" "Screen Extended"
  fi
''
