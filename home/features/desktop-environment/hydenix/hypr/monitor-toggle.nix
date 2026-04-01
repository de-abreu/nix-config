{ pkgs, ... }:
let
  monitor-toggle = pkgs.writeShellScriptBin "monitor-toggle" ''
    set -euo pipefail

    STATE_DIR="''${XDG_STATE_HOME:-$HOME/.local/state}/monitor-toggle"
    STATE_FILE="$STATE_DIR/state"
    mkdir -p "$STATE_DIR"

    get_primary_resolution() {
      hyprctl monitors -j | jq -r '.[] | select(.focused == true) | .width'
    }

    get_primary_height() {
      hyprctl monitors -j | jq -r '.[] | select(.focused == true) | .height'
    }

    get_primary_name() {
      hyprctl monitors -j | jq -r '.[] | select(.focused == true) | .name'
    }

    get_secondary_name() {
      hyprctl monitors -j | jq -r '.[] | select(.focused == false) | .name' | head -1
    }

    get_mirroring_monitor() {
      hyprctl monitors -j | jq -r '.[] | select(.mirrorOf != null and .mirrorOf != "none") | .name' | head -1
    }

    load_state() {
      if [[ -f "$STATE_FILE" ]]; then
        source "$STATE_FILE"
      else
        DIRECTION="right"
        echo "DIRECTION=right" > "$STATE_FILE"
      fi
    }

    get_extension_position() {
      local primary_width=$(get_primary_resolution)
      local primary_height=$(get_primary_height)

      case "$DIRECTION" in
        right) echo "''${primary_width}x0" ;;
        left)  echo "0x0" ;;
        above) echo "0x0" ;;
        below) echo "0x''${primary_height}" ;;
        *)     echo "''${primary_width}x0" ;;
      esac
    }

    set_extended() {
      local secondary=$(get_secondary_name)
      if [[ -z "$secondary" ]]; then
        echo "No secondary monitor found"
        exit 1
      fi

      local position=$(get_extension_position)
      hyprctl keyword monitor "$secondary,preferred,$position,1"
      echo "Switched to extended mode ($DIRECTION)"
    }

    set_mirrored() {
      local secondary=$(get_secondary_name)
      local primary=$(get_primary_name)

      if [[ -z "$secondary" ]]; then
        echo "No secondary monitor found"
        exit 1
      fi

      hyprctl keyword monitor "$secondary,preferred,auto,1,mirror,$primary"
      echo "Switched to mirrored mode"
    }

    toggle() {
      local mirroring=$(get_mirroring_monitor)

      if [[ -n "$mirroring" ]]; then
        set_extended
      else
        set_mirrored
      fi
    }

    set_direction() {
      local new_direction="$1"
      case "$new_direction" in
        left|right|above|below)
          DIRECTION="$new_direction"
          echo "DIRECTION=$new_direction" > "$STATE_FILE"
          echo "Extension direction set to: $new_direction"
          ;;
        *)
          echo "Invalid direction. Use: left, right, above, or below"
          exit 1
          ;;
      esac
    }

    show_help() {
      echo "Usage: monitor-toggle [COMMAND]"
      echo ""
      echo "Commands:"
      echo "  toggle    Toggle between mirror and extend modes (default)"
      echo "  status    Show current monitor configuration"
      echo "  direction Set extension direction (left|right|above|below)"
      echo "  mirror    Switch to mirrored mode"
      echo "  extend    Switch to extended mode"
      echo "  help      Show this help message"
    }

    show_status() {
      local primary=$(get_primary_name)
      local secondary=$(get_secondary_name)
      local mirroring=$(get_mirroring_monitor)

      load_state

      echo "Primary monitor: $primary"
      echo "Secondary monitor: $secondary"

      if [[ -n "$mirroring" ]]; then
        echo "Current mode: mirrored"
      else
        echo "Current mode: extended ($DIRECTION)"
      fi
    }

    main() {
      load_state

      case "''${1:-toggle}" in
        toggle)  toggle ;;
        status)  show_status ;;
        direction)
          if [[ -n "''${2:-}" ]]; then
            set_direction "$2"
          else
            echo "Current direction: $DIRECTION"
            echo "Usage: monitor-toggle direction (left|right|above|below)"
          fi
          ;;
        mirror)  set_mirrored ;;
        extend)  set_extended ;;
        help|--help|-h) show_help ;;
        *)       show_help ;;
      esac
    }

    main "$@"
  '';
in
{
  home.packages = [ monitor-toggle ];
}