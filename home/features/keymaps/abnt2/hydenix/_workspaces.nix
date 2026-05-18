{lib}: {hyprmode ? false}:
with lib; let
  mod_key =
    if hyprmode
    then ""
    else "$mainMod";
  count = range 1 10;

  navigate = let
    bind = n: "bindd = ${mod_key}, ${mod n 10 |> toString}, $d navigate to workspace ${toString n}, workspace, ${toString n}";
  in
    map bind count |> concatLines;

  move = let
    bind = n: "bindd = ${mod_key} Shift, ${mod n 10 |> toString}, $d move to workspace ${toString n}, movetoworkspace, ${toString n}";
  in
    map bind count |> concatLines;

  move-silently = let
    bind = n: "bindd = ${mod_key} Alt, ${mod n 10 |> toString}, $d move silently to workspace ${toString n}, movetoworkspacesilent, ${toString n}";
  in
    map bind count |> concatLines;
in
  # hyprlang
  ''
    $ws = Workspaces

    $d=[$ws|Navigation]
    ${navigate}
    bindd = ${mod_key}, S, $d toggle scratchpad, togglespecialworkspace

    $d=[$ws|Navigation|Relative workspace]
    bindd = ${mod_key}, D, $d change to nearest empty workspace, workspace, empty
    bindd = ${mod_key}, A, $d change active workspace backwards, workspace, r-1
    bindd = ${mod_key}, F, $d change active workspace forwards, workspace, r+1

    $d=[$ws|Move window]
    ${move}
    bindd = ${mod_key} Shift, S, $d move to scratchpad, movetoworkspace, special

    $d=[$ws|Move window|Relative workspace]
    bindd = ${mod_key} Shift, A, $d move window to previous relative workspace, movetoworkspace, r-1
    bindd = ${mod_key} Shift, F, $d move window to next relative workspace , movetoworkspace, r+1
    bindd = ${mod_key} Shift, D, $d move to nearest empty workspace, movetoworkspace, empty

    $d=[$ws|Navigation|Move window silently]
    ${move-silently}
    bindd = ${mod_key} Alt, S, $d move to scratchpad (silent), movetoworkspacesilent, special

    $d=[$ws|Navigation|Move window silently|Relative workspace]
    bindd = ${mod_key} Alt, A, $d move window to previous relative workspace, movetoworkspacesilent, r-1
    bindd = ${mod_key} Alt, F, $d move window to next relative workspace, movetoworkspacesilent, r+1
    bindd = ${mod_key} Alt, D, $d move to nearest empty workspace (silent), movetoworkspacesilent, empty
  ''
