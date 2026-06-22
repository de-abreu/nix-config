# shellcheck disable=SC2016
exec wezterm \
  --config "enable_tab_bar=false" \
  --config "initial_cols=120" \
  --config "initial_rows=40" \
  --config "window_close_confirmation=\"NeverPrompt\"" \
  start --class floating --cwd "$(pwd)" -- \
  bash -c '"$@"; rc=$?; if [ $rc -ne 0 ]; then echo "Command failed with exit code $rc"; read -n1 -p "Press any key to close..."; fi; exit $rc' _ "$@"
