navi_out=$(mktemp /tmp/cheatsheet-output-XXXXXX)
trap 'rm -f "$navi_out"' EXIT

active_win=$(hyprctl activewindow -j | jq -r '.address')

wezterm-floating navi >"$navi_out"

if [ ! -s "$navi_out" ]; then
  exit 0
fi

result=$(cat "$navi_out")

hyprctl dispatch focuswindow "address:$active_win"

key="${result%% / *}"

# Hyprland dispatch commands (! prefix)
case "$key" in
!*)
  cmd="${key#!}"
  # shellcheck disable=SC2086
  hyprctl dispatch $cmd
  exit 0
  ;;
esac

# Commands (e.g. :exec, :bmark)
case "$key" in
:*)
  cmd="''${key%% *}"
  wtype "$cmd"
  wtype -k Return
  exit 0
  ;;
esac

# Parse modifier prefixes: A- (Alt), C- (Ctrl), S- (Shift)
mods=()
remaining="$key"
while :; do
  case "$remaining" in
  A-*)
    mods+=(-M alt)
    remaining="''${remaining#A-}"
    ;;
  C-*)
    mods+=(-M ctrl)
    remaining="''${remaining#C-}"
    ;;
  S-*)
    mods+=(-M shift)
    remaining="''${remaining#S-}"
    ;;
  *) break ;;
  esac
done

# Dispatch key using X11 keysym names
case "$remaining" in
BackSpace | \
  Caps_Lock | \
  Num_Lock | \
  Scroll_Lock | \
  Escape | \
  Down | \
  Up | \
  Left | \
  Right | \
  Page_Down | \
  Page_Up | \
  Return | \
  space | \
  Super_L | \
  Tab | \
  Print | \
  F[1-9] | F1[0-2])
  wtype "${mods[@]}" -k "$remaining"
  ;;
*)
  if [ ''${#mods[@]} -gt 0 ]; then
    wtype "${mods[@]}" "$remaining"
  else
    wtype "$remaining"
  fi
  ;;
esac
