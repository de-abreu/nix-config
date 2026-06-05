font_size=21
markdown_file=""

while [[ $# -gt 0 ]]; do
  case "$1" in
  -s | --font-size)
    font_size="$2"
    shift 2
    ;;
  -*)
    echo "Usage: $0 [--font-size SIZE] <markdown-file>" >&2
    exit 1
    ;;
  *)
    markdown_file=$(realpath "$1")
    shift
    ;;
  esac
done

if [[ -z "$markdown_file" ]]; then
  echo "Usage: $0 [--font-size SIZE] <markdown-file>" >&2
  exit 1
fi

if [[ ! -f "$markdown_file" ]]; then
  echo "Error: File '$markdown_file' not found" >&2
  exit 1
fi

wezterm \
  --config "enable_tab_bar=false" \
  --config "font_size=${font_size}" \
  start \
  --class "presenterm" \
  -- presenterm "$markdown_file" &

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
