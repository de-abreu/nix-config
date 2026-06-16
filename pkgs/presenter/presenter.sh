font_size=21
presenterm_args=()

while [[ $# -gt 0 ]]; do
  case "$1" in
  -s | --font-size)
    font_size="$2"
    shift 2
    ;;
  *)
    presenterm_args+=("$1")
    shift
    ;;
  esac
done

if [[ ${#presenterm_args[@]} -eq 0 ]]; then
  echo "Usage: $0 [--font-size SIZE] [presenterm-options...] <markdown-file>" >&2
  exit 1
fi

last_idx=$((${#presenterm_args[@]} - 1))
markdown_file="${presenterm_args[$last_idx]}"

if [[ ! -f "$markdown_file" ]]; then
  echo "Error: File '$markdown_file' not found" >&2
  echo "Usage: $0 [--font-size SIZE] [presenterm-options...] <markdown-file>" >&2
  exit 1
fi

markdown_file=$(realpath "$markdown_file")
presenterm_args[last_idx]="$markdown_file"

# shellcheck disable=SC2016
wezterm \
  --config "enable_tab_bar=false" \
  --config "font_size=${font_size}" \
  start \
  --class "presenterm" \
  --cwd "$(pwd)" \
  -- bash -c 'sleep 0.5; presenterm "$@"; rc=$?; if [ $rc -ne 0 ]; then echo "presenterm failed with exit code $rc"; read -n1 -p "Press any key to close..."; fi; exit $rc' _ "${presenterm_args[@]}" &

wezterm_pid=$!

for _ in $(seq 1 20); do
  addr=$(hyprctl clients -j | jq -r '[.[] | select(.class == "presenterm") | .address][0] // empty')
  if [[ -n "$addr" && "$addr" != "null" ]]; then
    hyprctl dispatch focuswindow "address:${addr}"
    hyprctl dispatch fullscreen 1
    break
  fi
  sleep 0.1
done

wait "$wezterm_pid" 2>/dev/null || true
