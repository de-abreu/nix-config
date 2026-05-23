% hyprland, wm, keybinds, shortcuts

## Launchers

# Application finder — Super+Space
echo "!exec hyde-shell rofilaunch d"

# Window switcher — Super+Tab
echo "!exec hyde-shell rofilaunch w"

# Keybind cheatsheet — Super+/
echo "!exec cheatsheet-navi"

# Emoji picker — Super+Comma
echo "!exec hyde-shell emoji-picker"

# Glyph picker — Super+Period
echo "!exec hyde-shell glyph-picker"

# Clipboard history — Super+V
echo "!exec hyde-shell cliphist -c"

# Menu layout options — Super+Shift+Space
echo "!exec hyde-shell rofiselect"

# Power options — Super+Apostrophe
echo "!exec hyde-shell logoutlaunch"

# Toggle dropdown terminal — Super+Ctrl+T
echo "!exec hyde-shell pypr console"

# Open game launcher — Super+Shift+G
echo "!exec hyde-shell gamelauncher"

# Toggle game mode — Super+Alt+G
echo "!exec hyde-shell gamemode"

## Window Management

# Close focused window — Super+Q
echo "!exec hyde-shell dontkillsteam"

# Toggle floating — Super+Y
echo "!togglefloating"

# Toggle grouping — Super+G
echo "!togglegroup"

# Toggle fullscreen — Super+Z
echo "!fullscreen"

# Toggle window pinning — Super+P
echo "!exec hyde-shell windowpin"

# Toggle split orientation — Super+I
echo "!togglesplit"

# Change active group backwards — Super+Left
echo "!changegroupactive b"

# Change active group forwards — Super+Right
echo "!changegroupactive f"

## Window Management — Focus

# Focus left — Super+J
echo "!movefocus l"

# Focus down — Super+K
echo "!movefocus u"

# Focus up — Super+L
echo "!movefocus d"

# Focus right — Super+Ç
echo "!movefocus r"

## Window Management — Move

# Move window left — Super+Shift+J
echo "!movewindoworgroup l"

# Move window up — Super+Shift+K
echo "!movewindoworgroup u"

# Move window down — Super+Shift+L
echo "!movewindoworgroup d"

# Move window right — Super+Shift+Ç
echo "!movewindoworgroup r"

## Window Management — Resize

# Resize window left — Super+Alt+J
echo "!resizeactive -30 0"

# Resize window down — Super+Alt+K
echo "!resizeactive 0 30"

# Resize window up — Super+Alt+L
echo "!resizeactive 0 -30"

# Resize window right — Super+Alt+Ç
echo "!resizeactive 30 0"

## Workspaces

# Navigate to workspace N — Super+N (1-9, 0 for 10)
echo "!workspace <workspace>"

# Toggle scratchpad — Super+S
echo "!togglespecialworkspace"

# Change to nearest empty workspace — Super+D
echo "!workspace empty"

# Change workspace backwards — Super+A
echo "!workspace r-1"

# Change workspace forwards — Super+F
echo "!workspace r+1"

# Move window to workspace N — Super+Shift+N (1-9, 0 for 10)
echo "!movetoworkspace <workspace>"

# Move window to scratchpad — Super+Shift+S
echo "!movetoworkspace special"

# Move window silently to workspace N — Super+Alt+N (1-9, 0 for 10)
echo "!movetoworkspacesilent <workspace>"

## Theming

# Change wallpaper — Super+Shift+W
echo "!exec hyde-shell wallpaper -SG"

# Select theme — Super+Shift+T
echo "!exec hyde-shell themeselect"

# Select animations — Super+Shift+Y
echo "!exec hyde-shell animations --select"

# Select lock screen layout — Super+Shift+U
echo "!exec hyde-shell hyprlock --select"

## Hardware Controls

# Toggle mute audio — XF86AudioMute
echo "!exec hyde-shell volumecontrol -o m"

# Lower volume — XF86AudioLowerVolume
echo "!exec wpctl set-mute @DEFAULT_AUDIO_SINK@ 0; hyde-shell volumecontrol -o d"

# Raise volume — XF86AudioRaiseVolume
echo "!exec wpctl set-mute @DEFAULT_AUDIO_SINK@ 0; hyde-shell volumecontrol -o i"

# Toggle microphone — F7
echo "!exec hyde-shell volumecontrol -i m"

# Previous track — XF86AudioPrev
echo "!exec playerctl previous"

# Play/Pause — XF86AudioPlay
echo "!exec playerctl play-pause"

# Next track — XF86AudioNext
echo "!exec playerctl next"

# Increase brightness — XF86MonBrightnessUp
echo "!exec hyde-shell brightnesscontrol i"

# Decrease brightness — XF86MonBrightnessDown
echo "!exec hyde-shell brightnesscontrol d"

# Suspend — XF86PowerOff
echo "!exec playerctl pause; loginctl lock-session; systemctl suspend"

# Toggle mirror/extend display — XF86Display
echo "!exec monitor-toggle"